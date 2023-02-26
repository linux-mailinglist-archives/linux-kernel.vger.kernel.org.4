Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4686A3428
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 21:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBZU5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 15:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZU47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:56:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5512813D4E;
        Sun, 26 Feb 2023 12:56:58 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31QEfrG2006015;
        Sun, 26 Feb 2023 20:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=t8oFk89ZY/zT119kpdh2iJr/fkMcJ6oJSnek0l/8WhU=;
 b=EaAYambwVTVNlXewiJADiJI9NSJhb4dxt/FOS1U6Sa2pWzwRXzP2b8Zr/YYKWVLxcBcd
 N26i8F9+uetfG4/IK+MGr19AB9J7QNRxg+rIOdR/qPJMT3bko+50Su7bkyga9wtXWBkh
 NHeIRY6vAZcUNq0wJPgrq8byauNnyxPPBZYAIUdHTaBj++jB0XOFwEMBGmM7qUZ60I47
 6TihYu5zJYTUHpHWL/M/cOWQRfHg0jDsOhrvtfjuoERmBNNcZy+Bx2k2EhuLkq0pfbyn
 9XXpfjVCM1ir1zd1VMgho2kEQ5hbKjiMl7a4jnmrequ/xTuMHOVwoZ5lSqFdtADRy64K ag== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nyvda7yye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Feb 2023 20:56:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31QCpBCS030604;
        Sun, 26 Feb 2023 20:56:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3nybcq1aax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Feb 2023 20:56:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31QKuk4k56492324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Feb 2023 20:56:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91B4220043;
        Sun, 26 Feb 2023 20:56:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ABB420040;
        Sun, 26 Feb 2023 20:56:46 +0000 (GMT)
Received: from osiris (unknown [9.179.8.15])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun, 26 Feb 2023 20:56:45 +0000 (GMT)
Date:   Sun, 26 Feb 2023 21:56:44 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/rwonce: add READ_ONCE_ALIGNED_128() macro
Message-ID: <Y/vHjFRIJTTKVcFq@osiris>
References: <20230224100237.3247871-1-hca@linux.ibm.com>
 <20230224100237.3247871-2-hca@linux.ibm.com>
 <Y/o8cmyc7IW+28S2@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/o8cmyc7IW+28S2@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Plf8aY47XxXieUl9J7sw0XbdK4y4mvE7
X-Proofpoint-ORIG-GUID: Plf8aY47XxXieUl9J7sw0XbdK4y4mvE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_18,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 mlxlogscore=535 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302260173
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 05:50:58PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 24, 2023 at 11:02:36AM +0100, Heiko Carstens wrote:
> > Add an s390 specific READ_ONCE_ALIGNED_128() helper, which can be used for
> > fast block concurrent (atomic) 128-bit accesses.
> > 
> > The used lpq instruction requires 128-bit alignment. This is also the
> > reason why the compiler doesn't emit this instruction if __READ_ONCE() is
> > used for 128-bit accesses.
> 
> Does your u128 not have natural alignment? Does it help if you force
> align the u128 type?

s390 seems to be the only architecture which has a 64 bit alignment for
__uint128_t. But making it explicitly naturally aligned doesn't help.
I guess that's because the lpq instruction requires an even-odd register
pair where it reads to, while the now used lmg instruction can use any
register pair; but lmg doesn't come with atomic semantics.
