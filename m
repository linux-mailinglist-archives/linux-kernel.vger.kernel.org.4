Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246CF746E08
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGDJ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjGDJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:56:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96E0CA;
        Tue,  4 Jul 2023 02:56:15 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qGclY-00040o-SF; Tue, 04 Jul 2023 11:56:12 +0200
Message-ID: <db4bf839-df6a-c2b9-a03c-3b9d1680c2a9@leemhuis.info>
Date:   Tue, 4 Jul 2023 11:56:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6.3 00/13] 6.3.12-rc1 review
Content-Language: en-US, de-DE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230703184519.206275653@linuxfoundation.org>
 <CA+G9fYvf-sw8tCHjxhoMvHrtzzdE69EwvB2PmypUkGDdCFFASA@mail.gmail.com>
 <2023070411-steadfast-overtly-02a3@gregkh>
 <2023070416-wow-phrasing-b92c@gregkh>
 <37f9e884-6535-1ed7-8675-d98d0a6d8b36@oracle.com>
 <2023070444-untimed-clerical-565a@gregkh>
From:   Thorsten Leemhuis <linux@leemhuis.info>
In-Reply-To: <2023070444-untimed-clerical-565a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1688464577;42f6fc46;
X-HE-SMSGID: 1qGclY-00040o-SF
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.07.23 10:47, Greg Kroah-Hartman wrote:
> On Tue, Jul 04, 2023 at 02:13:03PM +0530, Harshit Mogalapalli wrote:
>> On 04/07/23 1:54 pm, Greg Kroah-Hartman wrote:
>>>>> While running LTP hugetlb testing on x86 the following kernel BUG noticed
>>>>> on running stable-rc 6.3.12-rc1.
>>
>> Have you looked at Patch 9 of this series:
>>
>> https://lore.kernel.org/stable/2023070416-wow-phrasing-b92c@gregkh/T/#m12068530e846ac8b9668bd83941d82ec3f22ac15
>>
>> Looks very much related, it also has a note on Backporting.
>> As I think it could be related, I am sharing this.(But haven't tested
>> anything)
> 
> Yes, that's the offending patch.  I should have read over the full
> changelogs before doing bisection, but bisection/test proved that this
> was not correct for 6.3.y at this point in time.

FWIW, I'm preparing a few small tweaks for
Documentation/process/stable-kernel-rules.rst (to be submitted after the
merge window). I among others consider adding something like this that
might help avoiding this situation:

```
To delay pick up of patches submitted via :ref:`option_1`, use the
following format:

.. code-block:: none

     Cc: <stable@vger.kernel.org> # after 4 weeks in mainline

For any other requests related to patches submitted via :ref:`option_1`,
just add a note to the stable tag. This for example can be used to point
out known problems:

.. code-block:: none

     Cc: <stable@vger.kernel.org> # see patch description, needs
adjustments for 6.3 and earlier

```

Greg, if this is stupid or in case you want it to say something else,
just say so.

Ciao, Thorsten
