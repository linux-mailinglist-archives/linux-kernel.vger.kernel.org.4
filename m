Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E3B70B930
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjEVJiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjEVJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:38:16 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857271AD;
        Mon, 22 May 2023 02:37:48 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q11yt-0007Y3-RF; Mon, 22 May 2023 11:37:31 +0200
Message-ID: <d1aee7d3-05f6-0920-b8e1-4ed5cf3f9f70@leemhuis.info>
Date:   Mon, 22 May 2023 11:37:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 2/2] drm/ofdrm: Update expected device name
Content-Language: en-US, de-DE
To:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Cyril Brulebois <cyril@debamax.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh@kernel.org>,
        Michal Suchanek <msuchanek@suse.de>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230412095509.2196162-1-cyril@debamax.com>
 <20230412095509.2196162-3-cyril@debamax.com>
 <CAMuHMdW4rZn4p=gQZRWQQSEbQPmzZUd5eN+kP_Yr7bLgTHyvig@mail.gmail.com>
 <5694a9ab-d474-c101-9398-eea55aab29df@suse.de>
 <10077a22-3055-75dd-2168-310468618f99@gmx.de>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <10077a22-3055-75dd-2168-310468618f99@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684748268;4b478383;
X-HE-SMSGID: 1q11yt-0007Y3-RF
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Was a proper solution for the regression the initial mail in this thread
is about ever found? Doesn't look like it for here, but maybe I'm
missing something.

Reminder, the problem afaik is caused by 241d2fb56a ("of: Make OF
framebuffer device names unique") [merged for v6.2-rc8, authored by
Michal Suchanek; committed by Rob Herring].

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 24.04.23 11:35, Helge Deller wrote:
> On 4/24/23 11:07, Thomas Zimmermann wrote:
>> Am 24.04.23 um 09:33 schrieb Geert Uytterhoeven:
>>> On Wed, Apr 12, 2023 at 12:05 PM Cyril Brulebois <cyril@debamax.com>
>>> wrote:
>>>> Since commit 241d2fb56a18 ("of: Make OF framebuffer device names
>>>> unique"),
>>>> as spotted by Frédéric Bonnard, the historical "of-display" device is
>>>> gone: the updated logic creates "of-display.0" instead, then as many
>>>> "of-display.N" as required.
>>>>
>>>> This means that offb no longer finds the expected device, which
>>>> prevents
>>>> the Debian Installer from setting up its interface, at least on
>>>> ppc64el.
>>>>
>>>> Given the code similarity it is likely to affect ofdrm in the same way.
>>>>
>>>> It might be better to iterate on all possible nodes, but updating the
>>>> hardcoded device from "of-display" to "of-display.0" is likely to help
>>>> as a first step.
>>>>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217328
>>>> Link: https://bugs.debian.org/1033058
>>>> Fixes: 241d2fb56a18 ("of: Make OF framebuffer device names unique")
>>>> Cc: stable@vger.kernel.org # v6.2+
>>>> Signed-off-by: Cyril Brulebois <cyril@debamax.com>
>>>
>>> Thanks for your patch, which is now commit 3a9d8ea2539ebebd
>>> ("drm/ofdrm: Update expected device name") in fbdev/for-next.
>>>
>>>> --- a/drivers/gpu/drm/tiny/ofdrm.c
>>>> +++ b/drivers/gpu/drm/tiny/ofdrm.c
>>>> @@ -1390,7 +1390,7 @@ MODULE_DEVICE_TABLE(of, ofdrm_of_match_display);
>>>>
>>>>   static struct platform_driver ofdrm_platform_driver = {
>>>>          .driver = {
>>>> -               .name = "of-display",
>>>> +               .name = "of-display.0",
>>>>                  .of_match_table = ofdrm_of_match_display,
>>>>          },
>>>>          .probe = ofdrm_probe,
>>>
>>> Same comment as for "[PATCH 1/2] fbdev/offb: Update expected device
>>> name".
>>>
>>> https://lore.kernel.org/r/CAMuHMdVGEeAsmb4tAuuqqGJ-4+BBETwEwYJA+M9NyJv0BJ_hNg@mail.gmail.com
>>
>> Sorry that I missed this patch. I agree that it's probably not
>> correct. At least in ofdrm, we want to be able to use multiple
>> framebuffers at the same time; a feature that has been broken by this
>> change.
> 
> Geert & Thomas, thanks for the review!
> 
> I've dropped both patches from fbdev tree for now.
> Would be great to find another good solution though, as it breaks the
> debian
> installer.
> 
> Helge
