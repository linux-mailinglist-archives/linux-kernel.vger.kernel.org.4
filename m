Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE2172FB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243099AbjFNKlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243282AbjFNKlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:41:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173421FE6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:41:10 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EACBqK027985;
        Wed, 14 Jun 2023 10:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=YGrMD4cl4xiY5lah9RxpP0ui8vXt7Wfl0Z3au1eFnhE=;
 b=RC1Ga97pbDl/EohK0kgwEAdiFod7iqnobHW9u2gw6A6tNkUcd/YnCRomYvyyvZcO0Mxu
 bSHG6qLWC65mGRS3fpg74wUlCXQZ7zC26LaFMFePxn04XP4SEbwvYs3x2Hc6B1qUKVsv
 Ls6xQAWAE2Zbc60YODh1qbQVSiGcgR8ZE4QYmuZneTG3I4L9b+c5ERPEJ4UWYsXCLC9E
 wGQ8zWs3sKa+XRDD8z77ugjqOo0wL6cIjaW2/yBoP65dcjDV4TBxmx5dQF0OIkKePtIQ
 el7PbAkCZXjRix2N+ZGaM6SWqRLdYESNtg6BhkzWfXHnXrflIloNiyKUfCMVbX37U2Gx zg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7bk8gy9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 10:41:07 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35DNbDk4017134;
        Wed, 14 Jun 2023 10:41:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt52u46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 10:41:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35EAf2IB17891992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 10:41:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBC7B2004B;
        Wed, 14 Jun 2023 10:41:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98FD020043;
        Wed, 14 Jun 2023 10:41:02 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 14 Jun 2023 10:41:02 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix memcpy size when copying stack entries
References: <20230612160748.4082850-1-svens@linux.ibm.com>
        <20230612123407.5ebcabdf@gandalf.local.home>
        <yt9dy1koey7h.fsf@linux.ibm.com>
        <20230613113737.1e07c892@gandalf.local.home>
Date:   Wed, 14 Jun 2023 12:41:02 +0200
In-Reply-To: <20230613113737.1e07c892@gandalf.local.home> (Steven Rostedt's
        message of "Tue, 13 Jun 2023 11:37:37 -0400")
Message-ID: <yt9dttva8gxt.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J5N_CvpIxMC7zKXuDSRESldTzk_3hfFz
X-Proofpoint-GUID: J5N_CvpIxMC7zKXuDSRESldTzk_3hfFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_06,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=730
 lowpriorityscore=0 mlxscore=0 clxscore=1015 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306140090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue, 13 Jun 2023 07:19:14 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
>
>> > Yes the above may be special, but your patch breaks it.  
>> 
>> Indeed, i'm feeling a bit stupid for sending that patch, should have
>> used my brain during reading the source. Thanks for the explanation.
>
> Does this quiet the fortifier?
> [..]

No, still getting the same warning:

[    2.302776] memcpy: detected field-spanning write (size 104) of single field "stack" at kernel/trace/trace.c:3178 (size 64)

