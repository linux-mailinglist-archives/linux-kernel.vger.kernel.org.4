Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453686F5F91
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjECUA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjECUAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:00:51 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C50869E
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 13:00:42 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 3C63B23FA3;
        Wed,  3 May 2023 16:00:38 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1puIeT-40E-00; Wed, 03 May 2023 22:00:37 +0200
Date:   Wed, 3 May 2023 22:00:37 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Jeff Chua <jeff.chua.linux@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ALSA development <alsa-devel@alsa-project.org>
Subject: Re: linux-6.4 alsa sound broken
Message-ID: <ZFK9ZSm34Z3hQPF4@ugly>
Mail-Followup-To: Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.de>, Jeff Chua <jeff.chua.linux@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ALSA development <alsa-devel@alsa-project.org>
References: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
 <ZE9ngFLRqLkN6faH@ugly>
 <87wn1pmm4d.wl-tiwai@suse.de>
 <7b80ef1e-23dd-c523-0663-4bf311c1823a@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7b80ef1e-23dd-c523-0663-4bf311c1823a@perex.cz>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 09:32:02PM +0200, Jaroslav Kysela wrote:
>On 03. 05. 23 18:10, Takashi Iwai wrote:
>> The dmix uses the silence_size=boundary as a fill-all operation, and
>> it's a free-wheel mode, so supposedly something was overlooked in your
>> code refactoring.
>> 
>> Could you check it and address quickly?  I'd like to fix it before
>> 6.4-rc1 release, so if no fix comes up in a couple of days, I'll have
>> to revert the change for 6.4-rc1.
>
>I would revert this patch.

> It seems that this "do silence right after the playback is finished" 
> mechanism is not handled in the updated code (and I overlooked that, 
> too):
>
no, there is nothing wrong with the code _per se_.

what's happening is that the dmix plugin doesn't update the application 
pointer, and somehow gets away with it.

that means that it would have never worked with thresholded silencing 
mode, either, but, well, it uses top-up mode.

anyway, this means that we need to revert the code path for top-up mode, 
which means reverting most of the patch's "meat".
i think i can do better than your proposal, but not today anymore.

fwiw, the echo results from the plugin apparently summing up the samples 
in the buffer without clearing it first, that is, it relies on the 
auto-silencing doing the clearing, which the patch broke under the given 
circumstances. rather obvious in retrospect.

regards
