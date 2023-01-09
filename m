Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98870662CE8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjAIRfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbjAIRfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:35:25 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05160B7E3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:35:14 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309FlSos016268;
        Mon, 9 Jan 2023 17:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yyS9R9F/aJXxFCcyr2ffyOpM0MkurazgQVmRGeFVaBU=;
 b=sWTf7Mcq9JLpzixFAwfk2ugC6V/8LKofbBAG1eT/ac32j5Xq48RxmoM/yHF2WN0p4jex
 oIbdAqIRJWkOg8RnuX9WYMA+sdsZH8ar1QfW+VdrhY6Yk3zpa4CfjI+ev0dN/D/NOfRa
 6j95XRw15ne+4pXqGpkJfKSqCnqIZIsyLcob+CbJU/GGnKVHsjQ/nJ3l+CsKpluG5Uj7
 DxLOWFgwuI2Hs1m7ggAlDWingEfUPjt3MPSdDSQPRHdd72TJDoTGfzzB5XqpE+buXZPL
 V/ATdGtyVZGLt7Qj/lWMklM8LHWEVHKRFWcXFpqjMg6AZVbp8jUyD2H0Fre5w40V+olr zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3myj6jn0ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 17:34:37 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 309HGmLE016228;
        Mon, 9 Jan 2023 17:34:36 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3myj6jn09q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 17:34:36 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3097F8UJ027702;
        Mon, 9 Jan 2023 17:34:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3my0c6jbcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 17:34:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 309HYV8U38797688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jan 2023 17:34:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4259F20049;
        Mon,  9 Jan 2023 17:34:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC0C720063;
        Mon,  9 Jan 2023 17:34:27 +0000 (GMT)
Received: from [9.43.119.183] (unknown [9.43.119.183])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jan 2023 17:34:27 +0000 (GMT)
Message-ID: <45ea36ba-050c-f8e3-f85a-cf1d5c6a4e0f@linux.ibm.com>
Date:   Mon, 9 Jan 2023 23:04:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] objtool: continue if find_insn() fails in
 decode_instructions()
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        jpoimboe@redhat.com, peterz@infradead.org, aik@ozlabs.ru,
        mpe@ellerman.id.au, mingo@redhat.com, christophe.leroy@csgroup.eu,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        sfr@canb.auug.org.au, naveen.n.rao@linux.vnet.ibm.com,
        Sathvika Vasireddy <sv@linux.ibm.com>
References: <20221208072813.25799-1-sv@linux.ibm.com>
 <Y7lHsw4diDgVc9ip@gmail.com>
 <623307fe-a29a-c691-b07b-4d2168d4bdcc@linux.ibm.com>
 <Y7xGas4FAHFUtEJE@gmail.com>
From:   Sathvika Vasireddy <sv@linux.ibm.com>
In-Reply-To: <Y7xGas4FAHFUtEJE@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uH7pre-31K4LffNU0n3AHu0GNics0n17
X-Proofpoint-GUID: kMsD7Iw4SAZh1zGw7e7g_ngRzn3PoF-p
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_10,2023-01-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=866 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/01/23 22:23, Ingo Molnar wrote:
> * Sathvika Vasireddy <sv@linux.ibm.com> wrote:
>
>> Hi Ingo, Happy New Year!
> Happy New Year to you too! :-)
>
>> On 07/01/23 15:51, Ingo Molnar wrote:
>>> * Sathvika Vasireddy <sv@linux.ibm.com> wrote:
>>>
>>>> Currently, decode_instructions() is failing if it is not able to find
>>>> instruction, and this is happening since commit dbcdbdfdf137b4
>>>> ("objtool: Rework instruction -> symbol mapping") because it is
>>>> expecting instruction for STT_NOTYPE symbols.
>>>>
>>>> Due to this, the following objtool warnings are seen:
>>>>    [1] arch/powerpc/kernel/optprobes_head.o: warning: objtool: optprobe_template_end(): can't find starting instruction
>>>>    [2] arch/powerpc/kernel/kvm_emul.o: warning: objtool: kvm_template_end(): can't find starting instruction
>>>>    [3] arch/powerpc/kernel/head_64.o: warning: objtool: end_first_256B(): can't find starting instruction
>>>>
>>>> The warnings are thrown because find_insn() is failing for symbols that
>>>> are at the end of the file, or at the end of the section. Given how
>>>> STT_NOTYPE symbols are currently handled in decode_instructions(),
>>>> continue if the instruction is not found, instead of throwing warning
>>>> and returning.
>>>>
>>>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>>> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
>>> The SOB chain doesn't look valid: is Naveen N. Rao, the first SOB line, the
>>> author of the patch? If yes then a matching From: line is needed.
>>>
>>> Or if two people developed the patch, then Co-developed-by should be used:
>>>
>>>           Co-developed-by: First Co-Author <first@coauthor.example.org>
>>>           Signed-off-by: First Co-Author <first@coauthor.example.org>
>>>           Co-developed-by: Second Co-Author <second@coauthor.example.org>
>>>           Signed-off-by: Second Co-Author <second@coauthor.example.org>
>>>
>>> [ In this SOB sequence "Second Co-Author" is the one who submits the patch. ]
>>>
>>> [ Please only use Co-developed-by if actual lines of code were written by
>>>     the co-author that created copyrightable material - it's not a courtesy
>>>     tag. Reviewed-by/Acked-by/Tested-by can be used to credit non-code
>>>     contributions. ]
>> Thank you for the clarification, and for bringing these points to my
>> attention. I'll keep these things in mind. In this case, since both Naveen
>> N. Rao and I developed the patch, the below tags
>> are applicable.
>>
>>          Co-developed-by: First Co-Author <first@coauthor.example.org>
>>          Signed-off-by: First Co-Author <first@coauthor.example.org>
>>          Co-developed-by: Second Co-Author <second@coauthor.example.org>
>>          Signed-off-by: Second Co-Author <second@coauthor.example.org>
> ... while filling in your real names & email addresses I suppose. ;-)
Indeed :-)
>
>> However, I would be dropping this particular patch, since I think Nick's
>> patch [1] is better to fix the objtool issue.
>>
>> [1] - https://lore.kernel.org/linuxppc-dev/20221220101323.3119939-1-npiggin@gmail.com/
> Ok, I'll pick up Nick's fix, with these tags added for the PowerPC
> regression aspect and your review:
>
>    Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>    Reported-by: Sathvika Vasireddy <sv@linux.ibm.com>
>    Acked-by: Sathvika Vasireddy <sv@linux.ibm.com>
>
> To document & credit the efforts of your patch.

Sure, thank you!

- Sathvika

