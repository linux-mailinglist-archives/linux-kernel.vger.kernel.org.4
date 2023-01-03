Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE27965B968
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 03:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjACCfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 21:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjACCfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 21:35:43 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051B7FCA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 18:35:41 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302MlRWT019792;
        Tue, 3 Jan 2023 02:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=rRT4sXA0xI9UGLf8O03IE3hR7lWr3pnX+x8tZL3iJio=;
 b=hmiygfto2No5MySnQbhnA02U56jRezrn6I7j4UcseP8sfkqSC2n/o8xotBPb3defkQNs
 oq9L0G3eOJJvua7bWCgx2Zh9ZtyGYr4sWkvfmLTHaz6uKCT7CO6MMgst1NupN30TY04u
 C5JGpRzL8hpFANqEp4HG82qunLTymmpSUMh5ry7DpIo9Nzazm8fr+FucdQAuCEDRUlox
 kmsXz02yZLXqIG+Osrjk/k6FFGKXpIu72+lVxDdnhTfwAp/TeBrj2N6yWLC6N0ao9Z2j
 tNiDZ54YiIuKu+N0MmX3xW4oImBqbEqH58qPVGKTBrMBMRS+EjBcZenk/87BDOI0dsWR sA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mv8c7gw75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 02:35:36 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 38C612F1F8;
        Tue,  3 Jan 2023 02:35:35 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (unknown [16.231.227.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id EA05780A0ED;
        Tue,  3 Jan 2023 02:35:33 +0000 (UTC)
Date:   Tue, 3 Jan 2023 10:35:31 +0800
From:   Matt Hsiao <matt.hsiao@hpe.com>
To:     Yoochan Lee <yoochan1026@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: hpilo: Fix use-after-free in ilo_open
Message-ID: <20230103023531.GA26527@blofly.tw.rdlabs.hpecorp.net>
References: <20221231055310.2040648-1-yoochan1026@gmail.com>
 <Y7AHvYfZreO/G/kT@kroah.com>
 <CALQpDLfMjAE9_VtMO6e_iiPrciFNbksLQT3AB3QTGwZCNf5=sA@mail.gmail.com>
 <Y7AhLWSPE+2hnZ2I@kroah.com>
 <CALQpDLc4+-0st-U_s+09QCb2nmv=nQizheGXjhyKJLGS45zmZw@mail.gmail.com>
 <Y7A9ssF/WPVDMUKl@kroah.com>
 <CALQpDLdqW9UYfk_3AKXk-yiCtUize=HXDTM6h-nurH31j9FN8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALQpDLdqW9UYfk_3AKXk-yiCtUize=HXDTM6h-nurH31j9FN8A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: uBZYtFhdB6ET2vOHF_MMmfsICqAPyIks
X-Proofpoint-ORIG-GUID: uBZYtFhdB6ET2vOHF_MMmfsICqAPyIks
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 mlxlogscore=597 adultscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030021
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2023 at 10:19:14AM +0900, Yoochan Lee wrote:
> > And how can this device actually be removed from the system?  Is that
> > possible with this hardware?
> HP ILO device is connected by using LAN cable.
> Therefore, the detach function is triggered when the attacker
> physically detaches the LAN cable connected to the HP ILO device.

This is incorrect.

The iLO device is an SoC attached directly on the PCB board.
It cannot be removed like a PCMCIA card that you referred so the
patch cannot apply the same to iLO. This iLO SoC does have a NIC, but
detach the LAN cable connected to it does not remove the SoC itself from
the host CPU.

> 
> > And again, this is not the correct solution as you have way too many
> > reference counts happening here.  Please become more familiar with how
> > these all work before adding another one and causing more problems like
> > this patch did :(
> Okay, I'll find a better way to patch this bug.
> 
> Sincerely,
> Yoochan
> 
> 2022년 12월 31일 (토) 오후 10:48, Greg KH <gregkh@linuxfoundation.org>님이 작성:
> >
> > A: http://en.wikipedia.org/wiki/Top_post 
> > Q: Were do I find info about this thing called top-posting?
> > A: Because it messes up the order in which people normally read text.
> > Q: Why is top-posting such a bad thing?
> > A: Top-posting.
> > Q: What is the most annoying thing in e-mail?
> >
> > A: No.
> > Q: Should I include quotations after my reply?
> >
> > http://daringfireball.net/2007/07/on_top 
> >
> > On Sat, Dec 31, 2022 at 10:06:19PM +0900, Yoochan Lee wrote:
> > > Thanks.
> > >
> > > Since I don't have a real device, it is difficult to verify the bug dynamically.
> > > However, this type of race condition (i.e., b/w remove device and
> > > fops) is prevalently founded recently[1-3].
> > > Therefore, I think this bug can be triggered if a real device exists.
> >
> > And how can this device actually be removed from the system?  Is that
> > possible with this hardware?
> >
> > > The main reason for this race condition (i.e., b/w detach and fops) is
> > > there is no proper lock mechanism.
> > > I think the detach device function is delayed until the other
> > > operations (e.g., fops) is finished.
> > > To this end, I use kref to wait for the other operations.
> >
> > And again, this is not the correct solution as you have way too many
> > reference counts happening here.  Please become more familiar with how
> > these all work before adding another one and causing more problems like
> > this patch did :(
> >
> > > The tool I am making is currently under development, and it can find
> > > the race condition between detach function and fops.
> >
> > Then you MUST document this as it looks like your tool needs work.
> > Please read Documentation/process/researcher-guidelines.rst for what you
> > MUST do if you use a tool to find "issues" and send out random patches.
> >
> > good luck!
> >
> > greg k-h
