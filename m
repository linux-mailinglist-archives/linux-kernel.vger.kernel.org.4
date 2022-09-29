Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0A55EF393
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiI2Kgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbiI2Kgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:36:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A23B13D1DC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:36:41 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TAM2td005732;
        Thu, 29 Sep 2022 10:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=MlPAGWC974VFWedeJYZKhv+TzRCwfMG8iyZ078IdKCQ=;
 b=N/a9md72XcfdUB9ZiidvBKMXnwuAz5PwQI/F1EcjuNhh1dDyPEeD46Fe9uPonzmaNW5n
 vcZkKl4ItuIxmX5/2NOsxuGPfGXebkJUPplOlMupXv0d1fihfI9+igyBdfh6D4D/5Sl4
 WGJs+izvhWvLm4T5HhcYvTQ+Rv/4Bfdqh7AwqdIFq1lrj5MZ0r75tsUlHFHjOTMBe6vH
 UGedlrAN41FDrFnVWuwVityAnXWTTmoSR20oTPPs2LznB2lC/73drWtGLG7g0F5J7OZm
 sqiL6zIxy64sMKj7noJAqIxXXVfiYpGz6w37MMf4MHyOP2xAgOUgYeSPybovMh7XD2O0 JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jw9j10bsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:36:38 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28TAMaqr007811;
        Thu, 29 Sep 2022 10:36:37 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jw9j10brv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:36:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28TAaCq3005466;
        Thu, 29 Sep 2022 10:36:35 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3jss5j6jas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:36:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28TAaWPw39321858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 10:36:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BB94A4069;
        Thu, 29 Sep 2022 10:36:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4084AA4064;
        Thu, 29 Sep 2022 10:36:32 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.242])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Sep 2022 10:36:32 +0000 (GMT)
Date:   Thu, 29 Sep 2022 12:36:30 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     xu.xin.sc@gmail.com, akpm@linux-foundation.org,
        imbrenda@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH 0/3] ksm: fix incorrect count of merged pages when
 enabling use_zero_pages
Message-ID: <20220929123630.0951b199@p-imbrenda>
In-Reply-To: <4a3daba6-18f9-d252-697c-197f65578c44@redhat.com>
References: <20220929025206.280970-1-xu.xin16@zte.com.cn>
        <4a3daba6-18f9-d252-697c-197f65578c44@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rw9PYcmB7cdoc5FCSt3K3DVh4ZmgNg8q
X-Proofpoint-ORIG-GUID: W39x4KoEUMvY6iEbDi-S6ckETqe_BaZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=860 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 11:21:44 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 29.09.22 04:52, xu.xin.sc@gmail.com wrote:
> > From: xu xin <xu.xin16@zte.com.cn>
> > 
> > Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
> > use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
> > after enabling use_zero_pages, all empty pages that are merged with
> > kernel zero page are not counted in pages_sharing or pages_shared.
> > That is because the rmap_items of these ksm zero pages are not
> > appended to The Stable Tree of KSM.
> > 
> > We need to add the count of empty pages to let users know how many empty
> > pages are merged with kernel zero page(s).
> > 
> > Please see the subsequent patches for details.  
> 
> Just raising the topic here because it's related to the KSM usage of the 
> shared zero-page:
> 
> MADV_UNMERGEABLE and other ways to trigger unsharing will *not* unshare 
> the shared zeropage as placed by KSM (which is against the 
> MADV_UNMERGEABLE documentation at least). It will only unshare actual 
> KSM pages. We might not want want to blindly unshare all shared 
> zeropages in applicable VMAs ... using a dedicated shared zero (KSM) 
> page -- instead of the generic zero page --  might be one way to handle 
> this cleaner.

I don't understand why do you need this.

first of all, one zero page would not be enough (depending on the
architecture, e.g. on s390x you need many). the whole point of zero
page merging is that one zero page is not enough.

second, once a page is merged with a zero page, it's not really handled
by KSM anymore. if you have a big allocation, of which you only touch a
few pages, would the rest be considered "merged"? no, it's just zero
pages, right?
this is the same, except that we take present pages with zeroes in it
and we discard them and map them to zero pages. it's kinda like if we
had never touched them.

> 
> Would that also fix some of the issues you describe above?
> 

