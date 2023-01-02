Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A0865B346
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjABOTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjABOTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:19:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269A22DF4;
        Mon,  2 Jan 2023 06:19:50 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302DNfvu022304;
        Mon, 2 Jan 2023 14:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=SmSK0ZiCh2xGKI09NnirV31fdAI+cA6V0YBVgRyJHdw=;
 b=og5Qw50gEOvIH41qyD9mH+HVE0FwH1SzFCx5/X9hDQRkO5y+NQNA7MA465kltEpoVceH
 nMcUaQGjLD9ooXdqjWaYglp+INR0hVEym8DTdMxsxaqjvub6qhlMvhmM/P4bb1Pan6iS
 TDB32xInTtCmHkFYAIlTcKCfeRg8L/R4dLaT4bX1HvGlWs+lJ+MsOYLKxrrQ9K6Y0qMx
 kwD05Ec9ctluQGNQexB7T/+k/xK6+g/eMHPGORM7izHt3GUf54Vxl3X/Ux92mBE0Xtch
 uBTn3394UEduoKFXKRcJhx3h+qexYpWlBLwlS24dDTiG6AZ/uv2FfnIMkQUDbUWOAGqX ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mv046s0rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 14:19:17 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 302E27ki021395;
        Mon, 2 Jan 2023 14:19:16 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mv046s0r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 14:19:16 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 302Cbl0T000437;
        Mon, 2 Jan 2023 14:19:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6hufu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 14:19:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 302EJBjP48628170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 14:19:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A64C20043;
        Mon,  2 Jan 2023 14:19:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42B5520040;
        Mon,  2 Jan 2023 14:19:11 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  2 Jan 2023 14:19:11 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] add s390 support to nolibc and rcutorture
References: <20230102105112.1661651-1-svens@linux.ibm.com>
        <20230102110252.GE29287@1wt.eu>
Date:   Mon, 02 Jan 2023 15:19:10 +0100
In-Reply-To: <20230102110252.GE29287@1wt.eu> (Willy Tarreau's message of "Mon,
        2 Jan 2023 12:02:52 +0100")
Message-ID: <yt9d358trpcx.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hDnKIScikmLacREHVEtjnCvvx7L2Q5F5
X-Proofpoint-GUID: WQLJfnQHF5B7Re7dZ46jYhGFXN5a_GBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_08,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=273 adultscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <w@1wt.eu> writes:

> On Mon, Jan 02, 2023 at 11:51:07AM +0100, Sven Schnelle wrote:
>> Hi,
>> 
>> these patches add support for the s390 architecture both to nolibc
>> and rcutorture. Note that this only adds support for the 64 bit
>> version, no support for 31 bit (compat) is added. For nolibc it
>> includes one bugfix to make the fd_set datatype match the kernel
>> type.
>> 
>> Changes in v2:
>> 
>> - use __attribute__((unused)) instead of __maybe_unused
>> - prefer aghi over lay, as lay is not present in all architecure levels
>> - add -m64 CFLAG to force 64 bit mode for compiler that can do 31bit and 64bit mode
>
> Excellent, now works out of the box for me, thank you Sven!.
>
> Paul, would you mind taking these ones for your dev branch instead
> of the previous ones ?

Hrm, while looking at the code to make the adjustments for the auxv
stuff, i noted that the envp handling in the startup code is wrong. So i
have to fix that and send a v3 of the patchset.
