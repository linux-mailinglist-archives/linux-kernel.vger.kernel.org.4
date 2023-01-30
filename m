Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3AB68148E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbjA3PQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbjA3PQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:16:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14B036FD8;
        Mon, 30 Jan 2023 07:16:21 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UF1Xrx008259;
        Mon, 30 Jan 2023 15:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=W9BdcaIZa+2CbjGP/obqUkNHmt68MgwR0hIvJ7x4abM=;
 b=kXso5KKz2cbZZu68jQtUsm6MSy/gQOylPmwiv0w+3dnrebFDsObdlN5+Jj45Mx551D6q
 hA+X5u4/r6YcONGg3CE26NeyBKjvsAtOma01kI+GnEz03FBETCsAy1zWb6MHvvrZycFy
 4xchu+G3IEyQHKnCZrzbmX1yRnupF6QaYAW+t6JicUVXexKmL6dBWY1hujRLJ4eB49Nw
 ItI9vvt2KZ509ljTvOFPvchLt5BLh/Nds5eze8y2leXkCAN7vRcD6aUWwGmwev2wR3Wr
 pjZE3+qbvkuo3jyk5mX7GgLr1yua2vDSdoscKERvvoe1Jaaz5ZvExAbciBeJ1P6Btryh 6Q== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3necs4p8k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 15:16:04 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30TDf4SP024689;
        Mon, 30 Jan 2023 15:16:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ncvv69qc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 15:16:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UFFvHB24445682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 15:15:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA16120043;
        Mon, 30 Jan 2023 15:15:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64D9620040;
        Mon, 30 Jan 2023 15:15:57 +0000 (GMT)
Received: from osiris (unknown [9.171.84.66])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 30 Jan 2023 15:15:57 +0000 (GMT)
Date:   Mon, 30 Jan 2023 16:15:55 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Terrell <terrelln@fb.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 1/1] s390/decompressor: specify __decompress() buf len to
 avoid overflow
Message-ID: <Y9ffKxhKv8Gan34Z@osiris>
References: <cover.thread-41c676.your-ad-here.call-01675030179-ext-9637@work.hours>
 <patch-1.thread-41c676.git-41c676c2d153.your-ad-here.call-01675030179-ext-9637@work.hours>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch-1.thread-41c676.git-41c676c2d153.your-ad-here.call-01675030179-ext-9637@work.hours>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wEcYJk9bULgvzMWitls2ymjD3I7ADRjw
X-Proofpoint-ORIG-GUID: wEcYJk9bULgvzMWitls2ymjD3I7ADRjw
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_14,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=544 spamscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300146
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 11:47:23PM +0100, Vasily Gorbik wrote:
> Historically calls to __decompress() didn't specify "out_len" parameter
> on many architectures including s390, expecting that no writes beyond
> uncompressed kernel image are performed. This has changed since commit
> 2aa14b1ab2c4 ("zstd: import usptream v1.5.2") which includes zstd library
> commit 6a7ede3dfccb ("Reduce size of dctx by reutilizing dst buffer
> (#2751)"). Now zstd decompression code might store literal buffer in
> the unwritten portion of the destination buffer. Since "out_len" is
> not set, it is considered to be unlimited and hence free to use for
> optimization needs. On s390 this might corrupt initrd or ipl report
> which are often placed right after the decompressor buffer. Luckily the
> size of uncompressed kernel image is already known to the decompressor,
> so to avoid the problem simply specify it in the "out_len" parameter.
> 
> Link: https://github.com/facebook/zstd/commit/6a7ede3dfccb
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  arch/s390/boot/decompressor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!
