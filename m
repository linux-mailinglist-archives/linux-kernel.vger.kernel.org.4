Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3D68946A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjBCJwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjBCJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:52:44 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C6670D7F;
        Fri,  3 Feb 2023 01:52:43 -0800 (PST)
Received: from [46.183.103.8] (helo=[172.18.99.178]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pNskI-0006KR-7u; Fri, 03 Feb 2023 10:52:38 +0100
Message-ID: <01038358-43e5-6df0-b260-e8f11c8d9e66@leemhuis.info>
Date:   Fri, 3 Feb 2023 10:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, de-DE
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
 <1f217c94-b90f-359a-2142-0d3ae5d84fc6@leemhuis.info>
 <20230202150856.lchr76nqih3vdul6@nitro.local>
 <ee3a168f-66e3-14a3-3890-90dc5c8153d1@leemhuis.info>
 <877cwz13tj.fsf@intel.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v1] docs: describe how to quickly build Linux
In-Reply-To: <877cwz13tj.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1675417963;c2b36712;
X-HE-SMSGID: 1pNskI-0006KR-7u
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.23 10:44, Jani Nikula wrote:
> On Thu, 02 Feb 2023, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>> On 02.02.23 16:08, Konstantin Ryabitsev wrote:
>>> On Thu, Feb 02, 2023 at 12:15:36PM +0100, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
>>>> Then I tried creating a shallow clone like this:
>>>>
>>>> git clone
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>> --depth 1 -b v6.1
>>>> git remote set-branches --add origin master
>>>> git fetch --all --shallow-exclude=v6.1
>>>> git remote add -t linux-6.1.y linux-stable
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>>>> git fetch --all --shallow-exclude=v6.1
>>>>
>>>> This took only roundabout 2 minutes and downloads & stores ~512 MByte
>>>> data (without checkout).
>>>
>>> Can we also include the option of just downloading the tarball, if it's a
>>> released version? That's the fastest and most lightweight option 100% of the
>>> time. :)
>>
>> Don't worry, that was in there and will stay in there:
>>
>> +   If you plan to only build one particular kernel version, download
>> its source
>> +   archive from https://kernel.org; afterwards extract its content to
>> '~/linux/'
>> +   and change into the directory created during extraction.
> 
> The trouble is, if this is for someone who needs to try kernels for
> debugging, a typical idea is to ask them to revert something or apply a
> patch. All the guides for that will be 'git revert' and 'git am'. Bisect
> is right up there on the list too. And then they'll first grab a tarball
> and fail,

Yeah, those are the reasons why I don't like the tarball approach too
much myself. Guess I should point them out in the text to make readers
aware of them...

> then do a shallow copy and fail,

The new test I wrote (still a draft) will suggest to use a recent
release as base, hence bisection or reverting a patch will be possible.
And if the range turns out to be to shallow, there is still "git fetch
--shallow-exclude=v6.1" to deepen it, which should avoid...

> and then finally get a full one... :p

...this scenario -- at least unless I missed anything.

Ciao, Thorsten

>>>> Not totally sure, but the shallow clone somehow feels more appropriate
>>>> for the use case (reminder, there is a "quickly" in the document title),
>>>> even if such a clone is less flexible (e.g. users have to manually add
>>>> stable branches they are interested it; and they need to be careful when
>>>> using git fetch).
>>>>
>>>> That's why I now strongly consider using the shallow clone method by
>>>> default in v2 of this text. Or does that also create a lot of load on
>>>> the servers? Or are there other strong reason why using a shallow clone
>>>> might be a bad idea for this use case?
>>>
>>> As I mentioned elsewhere, this is only a problem when it's done in batch mode
>>> by CI systems. A full clone uses pregenerated pack files and is very cheap,
>>> because it's effectively a sendfile operation. A shallow clone requires
>>> generating a brand new pack, compressing it, and then keeping it around in
>>> memory for the duration of the clone process. Not a big deal when a few humans
>>> here and there do it, but when 50 CI nodes do it all at once, it effectively
>>> becomes a DDoS. :)
>>
>> Thx again for your insights, much appreciated.
>>
>> Ciao, Thorsten
> 
