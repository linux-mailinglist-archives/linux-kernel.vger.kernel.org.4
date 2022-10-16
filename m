Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28E85FFEA2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJPKgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 06:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJPKfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 06:35:52 -0400
X-Greylist: delayed 2480 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Oct 2022 03:35:50 PDT
Received: from spamfilter04.delta.nl (spamfilter04.delta.nl [217.102.255.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4024136BE1;
        Sun, 16 Oct 2022 03:35:50 -0700 (PDT)
Received: from host-xbmmyvj.static.zeelandnet.nl ([217.102.255.196] helo=mail.caiway.net)
        by spamfilter04.delta.nl with esmtp (Exim 4.92)
        (envelope-from <8vvbbqzo567a@nospam.xutrox.com>)
        id 1ok0Kj-0006b8-TE; Sun, 16 Oct 2022 11:53:36 +0200
Received: from smtp-out.lan.xutrox.com (189-082-045-062.dynamic.caiway.nl [62.45.82.189])
        (Authenticated sender: gv47feqf@mail.intern)
        by mail.caiway.net (Postfix) with ESMTPA;
        Sun, 16 Oct 2022 11:53:19 +0200 (CEST)
Received: from [10.1.16.159] (unknown [10.1.16.159])
        by smtp-out.lan.xutrox.com (Postfix) with ESMTPS id BD187FC02;
        Sun, 16 Oct 2022 09:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xutrox.com; s=2021;
        t=1665913994; bh=VQr+zN5IdSJbTkt6kZSoTfCjC9CX89lo5WSU4Oh51VA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SlVzWhM7gzHyrWf2Is+cmnv8P8Uo0HLvkivrHHJE8gYHky1ZvU7ZYdcwPa+T9GJwA
         ewvNlk4ABzGekkmfyqXHWrMRFCV12l6Iu+DJuQsKXUT3I6FWx212vIO320VW9HWZGl
         yjRXK6sSHozL7QtcqZaWZcXqtGN/Slm7/4NmURjAMwaf0ZVcjUS9tdRXaoB0CgHktm
         6yC5utpO67rCd3gfmMibbuKhfFwtzr2eax66Kgm+byaiA2O+IfxqRwTsg/3MSjYBgq
         TKIO/TfIQpsKWH6ixxHVCyrhdJplPd+jIRUey3K/7+sBWyYQMz0eCuCYwsZmwCP4RQ
         TitNRIs/OtU3Q==
Message-ID: <b38ecb38-2709-0c75-fe08-375dd4a87d5f@nospam.xutrox.com>
Date:   Sun, 16 Oct 2022 11:53:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] x86/perf: Fixed kernel panic during boot on Nano
 processor.
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Cody Yao-oc <CodyYao-oc@zhaoxin.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, shyaololo@163.com
References: <20210607013109.7870-1-CodyYao-oc@zhaoxin.com>
 <Y0gpsTiUqa/ZbvRh@hirez.programming.kicks-ass.net>
From:   Arjan <8vvbbqzo567a@nospam.xutrox.com>
In-Reply-To: <Y0gpsTiUqa/ZbvRh@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: 217.102.255.196
X-DELTA-Domain: out.caiw.net
X-DELTA-Username: 217.102.255.196
Authentication-Results: delta.nl; auth=pass smtp.auth=217.102.255.196@out.caiw.net
X-DELTA-Outgoing-Class: ham
X-DELTA-Outgoing-Evidence: Combined (0.08)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8UY4s+Yiu0pHmfimn9rvSlPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5yc/ZmA9xtuv+B4ejtZ8Y/XuPlWyU6WxHGGYJjeNxb2qsSt
 0Cf6BPNJWEBZ4JVsQN2Mj8c81Cqq49L7i7V2/TcPuK4qf9MvYgQQjDkqI/9rxZYoT8DGBXy9+Yr+
 O7G/xc58iEjXbHIdUQr1yb+WzViLwOkTB5HjLhmTNASxhQlKkawLonlImQFKvyumeIUlInTJUFW9
 jMbE4Gan+bbHWts97JtuyuUsa+UkJaUpT81goTMcT+7lBOhaiNMPjogKlwA2Vz6Xcl+tcewiMUdS
 9dKp8n/ecEa8Dg/FYK5/AG7c3Xw3coVFbzLPseyHEBSmYPf2enzXTs9rqT37lCgCUdR3idMlhCno
 /QsYaTlhyywkGTkQIfeYgYqBXZFMF+hHi7rcf/ofBF/wWxzMV48oEn/pX75TBHUZZhA+DSPCGwhb
 mf1nsk4XUhGRAVSQpqHRZWu93416zKEUrygEsuACwklwhBZ1D9MqB0vOkd39ScIXDIgADrxOtZX/
 G/2/IJHRpYsEybI1sOftHmSKUCHCvcq0i2Zoq6H6kLA4Wl2kUl3ga+YBpscYeJb04ZvY3orHnLCK
 HGDdRzytiKbUp5w/JDfjebFJIl8Cs2xleGSAiDR0kCabsfRx4e7LLFIZzYf71k1ClA4krEnjzezq
 sOHwFT1OAkiBzRd+qpW+h72Ly10vJ2hraNDvBTgk5sUe41aq+SbzpCXrf0wnye0NpXW7y7JFdi8F
 1nhlaeIl7TcXogHLA82+93NDCACMp6nbho+VuenoAhng0cApE3VnDyxWqS9ije49tZ/AcfXvRATR
 Wfdyiz8vhaAa0BbMupM+1agz5SFBoGfS0DhK3BfvFNI4fRpBbmGFHU0Fd1FYwiLqVhSu3v+nCpyC
 SdscG09FH1xvLyw/tCJWEi8ikJPyVPcxcTsmzrq2gEhTddRghHFF286eW2BECiVcqfxUH1CXsod1
 GDa9T/D6wRI1MwUDobWxsDnf++DuIQUs/5JJj4C/n4CILggDdEKjdWhTTSQUWki9GRqNDKzYrBQ8
 NNYoick+UCNl6vQnbmdnIXmBiVs3DrWG6v8kkzJ31DiVWTkrDNDmTiVVH+9CVL3ZB2Yyd7DOQnkJ
 c+51jBq98UG160e1tbsqSvYKd+OWea/Dn/mjjvtwA+77nfS+qgRPwgrzwXmMZRRk1iZMHnbCQPlM
 eZImJMYmx+j2jy7rLCNyHfKB6IlRR4onrYqVWrke6X16VTjUWV4aXRiJsFizJhuZn6xfjuGHi1Ff
 EoXm0/FPF8PR0w363lka9gcwIn77Mi4NfMLw8oY1HjvSW5VJBhs3pLhA8z4xo5yTaZvlrLgXEO04
 ZsCn8Z2KSYfpjFwwpPrz3Gl8pJ0O2/zI9E4NYCVW2CC1DqO4EoK1MmeO+fNxBbg9NxwRtrmOhbzN
 5d3B/nx3oA8VLWDbIggCLPUzTJVdE6cxsYCz0RNkJWOv/F0pffRTyrYlS8M=
X-Report-Abuse-To: spam@spamfilter03.delta.nl
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-10-2022 17:07, Peter Zijlstra wrote:
> On Mon, Jun 07, 2021 at 09:31:09AM +0800, Cody Yao-oc wrote:
>> From: CodyYao-oc <CodyYao-oc@zhaoxin.com>
>>
>> Nano processor may not fully support rdpmc instruction, it works well
>> for reading general pmc counter, but will lead to GP(general protection)
>> when accessing fixed pmc counter. Futhermore, family/model information
>> is same between Nano processor and ZX-C processor, it leads to zhaoxin
>> pmu driver is wrongly loaded for Nano processor, which resulting boot
>> kernal fail.
>>
>> To solve this problem, stepping information will be checked to distinguish
>> between Nano processor and ZX-C processor.
>>
>> [https://bugzilla.kernel.org/show_bug.cgi?id=212389]
>>
>> Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
>> Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
> 
> *sigh*.. so this email address doesn't exist, as such I can't apply this
> patch. Consider it dropped.

If it's about my email address: The address exists and works.
If the nospam part bothers you, that part can be left out. You may leave the reported-by line out if you want to.
