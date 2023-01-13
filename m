Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A126697D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241671AbjAMM53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbjAMM4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:56:53 -0500
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2AC5FBD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:44:53 -0800 (PST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 78CCAA0040;
        Fri, 13 Jan 2023 13:44:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 78CCAA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1673613890; bh=TzCYWekeVeO9uFmb65AitJ1O7hak5JCY5nBfZC0eV1Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=2EgLb8RA/MNOulgcS+OV5eUJHrwhU9C2VKHd17CiF9fB4tkYFCq1Z5t1tj2S6fZOK
         tP/6usu8adIUGz/VmcFjD1ccQaNU/0a4bAKYIQaYOs+dJU7CqL9Qw7O7TcaxBiW4CW
         AnbN8H2RPZzlmNvF7su8SpNATtU2yJvByQzN4FBA=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Fri, 13 Jan 2023 13:44:46 +0100 (CET)
Message-ID: <abe92f46-d4d7-4d9d-82b3-d8c9e7e26181@perex.cz>
Date:   Fri, 13 Jan 2023 13:44:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ALSA: pcm: Move rwsem lock inside snd_ctl_elem_read to
 prevent UAF
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Clement Lecigne <clecigne@google.com>
References: <20230113120745.25464-1-tiwai@suse.de>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230113120745.25464-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 01. 23 13:07, Takashi Iwai wrote:
> From: Clement Lecigne <clecigne@google.com>
> 
> Takes rwsem lock inside snd_ctl_elem_read instead of snd_ctl_elem_read_user
> like it was done for write in commit 1fa4445f9adf1 ("ALSA: control - introduce
> snd_ctl_notify_one() helper"). Doing this way we are also fixing the following
> locking issue happening in the compat path which can be easily triggered and
> turned into an use-after-free.
> 
> 64-bits:
> snd_ctl_ioctl
>    snd_ctl_elem_read_user
>      [takes controls_rwsem]
>      snd_ctl_elem_read [lock properly held, all good]
>      [drops controls_rwsem]
> 
> 32-bits:
> snd_ctl_ioctl_compat
>    snd_ctl_elem_write_read_compat
>      ctl_elem_write_read
>        snd_ctl_elem_read [missing lock, not good]
> 
> CVE-2023-0266 was assigned for this issue.
> 
> Cc: stable@kernel.org # 5.13+
> Signed-off-by: Clement Lecigne <clecigne@google.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
