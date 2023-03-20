Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDACC6C203F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCTSro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCTSrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:47:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCB8BBA4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:40:27 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KGnlZu012201;
        Mon, 20 Mar 2023 18:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=87jA3nP94Gt3W8XLBgknFsevDqKzwkS3hRx0AdG0Uu4=;
 b=mdBtlEUV3XYE9Xbm+lb8mRsvabLK7tEEAupvPNpVRMnF7WCx+/8brHn9stgDZ+MneZRL
 fALJWX0Ug1kOqP9QTx/D5ld7xQKcOEn9ynYLzDdUjZ74xOiX/fzo5nMysEoZ8D1v8tdp
 wLFMIRw63foQ/cPwJ8kOrf+zzrLj7GH9q/Ppb5/8dQQtdRwQzqkTsFUWL/dHScrESbKB
 LCB3HtIpR2E2IiMFpRmqvwLo2rOJ2bxZbvNA42Oq+XFOEUmN9DJw47dIvPnIorGBgDI3
 hiJshEl+ibyxwLm1iGv07iIX+AL5jPJT1t0JTRXVtkY+KnFqpIrkiXGGwtZZl4s09kz6 CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pessywvqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 18:39:19 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32KGq0fY023204;
        Mon, 20 Mar 2023 18:39:19 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pessywvp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 18:39:18 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32KBQwEu018107;
        Mon, 20 Mar 2023 18:39:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3pd4jfb1qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 18:39:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32KIdE9r57803248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 18:39:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 678642004B;
        Mon, 20 Mar 2023 18:39:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C932020043;
        Mon, 20 Mar 2023 18:39:12 +0000 (GMT)
Received: from li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com (unknown [9.43.70.55])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Mar 2023 18:39:12 +0000 (GMT)
Date:   Tue, 21 Mar 2023 00:08:47 +0530
From:   Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Replace "<<" with BIT macro
Message-ID: <ZBioN46Imb07RQP2@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
References: <ZBVhmU+5dVoExIH9@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
 <6d78fc9c-59e2-4748-b6a8-65c937b111a2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d78fc9c-59e2-4748-b6a8-65c937b111a2@kili.mountain>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nRb6Bx4NWkMMcY66MJM4oQp25Q53GMUn
X-Proofpoint-ORIG-GUID: Y4YkIJhplNOFhANycvicLuThPNL5mIV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=723 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200156
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 10:51:00AM +0300, Dan Carpenter wrote:
> On Sat, Mar 18, 2023 at 12:30:41PM +0530, Abhirup Deb wrote:
> > -#define TSI148_PCFS_STAT_SELTIM        (3<<9)	/* DELSEL Timing */
> > +#define TSI148_PCFS_STAT_SELTIM        BIT(9)	/* DELSEL Timing */
> 
> This patch is buggy.
> 
> regards,
> dan carpenter

Dan,
Thank you for your help! I will be amending the changes in a v2 of the patch.

Regards,
Abhirup Deb
