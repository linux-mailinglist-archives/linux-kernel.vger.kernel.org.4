Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8926C717D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjCWUCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjCWUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:02:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161C28EBD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:02:00 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NHb9GP012594;
        Thu, 23 Mar 2023 20:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=eNfxwCHnvvaI0HPhukh3/fzOd3z0sV5WFxRLN34b3bc=;
 b=pB2HmH4CTn6HUwe1cSSYHKZgDlLULTPIdFItERI7RjZu8r2pNPVfWQYMZCri+0g027Nu
 g4XojyxkC0/UM5CBlAcZaS46KG+yNcggwxo/K1UBoEvLLS2hE2aQljgntZXsHLAExzu1
 2bZFb+j7o7dI97aknfYQkMtbU9vHL8XVdaikD2p1Tc57sbT6E9Lv2f+FU//kVIlURHlr
 HZC2Ge2H0LZfy9mojfaxxWSwGIgC21XnHA4cvJm8VUxtYizhbaSyRCTVwbNhYk9LFbNY
 ogPr6cweKWV5xGSpbFEEHy8ULn/htC/HMrYcjK8HYFxvxQ0jJXxkK4rhq91Lu3OUXLJJ EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgmc2yd7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 20:01:56 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32NJU2e1007859;
        Thu, 23 Mar 2023 20:01:56 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgmc2ycxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 20:01:56 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32N8jLER022346;
        Thu, 23 Mar 2023 20:01:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pd4x6fv9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 20:01:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32NK1XC133489478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 20:01:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA1AF20040;
        Thu, 23 Mar 2023 20:01:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DB742004D;
        Thu, 23 Mar 2023 20:01:32 +0000 (GMT)
Received: from li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com (unknown [9.43.63.38])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Mar 2023 20:01:31 +0000 (GMT)
Date:   Fri, 24 Mar 2023 01:31:23 +0530
From:   Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 RESEND] staging: vme_user: Replace "<<" with BIT macro
Message-ID: <ZBywE7I6AC4fLHLS@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
References: <ZBxOdihP+mygNsuS@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
 <9375f16c-5040-4355-8bd0-54c07763d6b3@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9375f16c-5040-4355-8bd0-54c07763d6b3@kili.mountain>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kp9Ku9h6Y0mGGsF-_D-_NsNen1GHg8Iu
X-Proofpoint-ORIG-GUID: _QUBhg-PBYUwHTX9S-RNmLwKCnOSf4WR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-23_13,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=726 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230147
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 04:34:06PM +0300, Dan Carpenter wrote:
> On Thu, Mar 23, 2023 at 06:34:54PM +0530, Abhirup Deb wrote:
> > Replace the "<<" operator with BIT macro, in accordance to the
> > checkpatch.pl script and Linux kernel coding-style guidelines.
> > 
> > Signed-off-by: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
> > ---
> > Changes in v2:
> >     - Refactor the patch & Replace the erroneous BIT macro in --
> >        "#define TSI148_PCFS_STAT_SELTIM        BIT(9)"
> >       with --
> >        "#define TSI148_PCFS_STAT_SELTIM        (3<<9)"
> > 
> 
> Why did you resend this?
> 
> regards,
> dan carpenter
>
Hey Dan,
Sorry,did not mean to spam! Mistake on my part!

Regards,
Abhirup Deb

