Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B584C6FDD7B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbjEJMJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbjEJMJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:09:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7605F7D9E;
        Wed, 10 May 2023 05:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A52463D94;
        Wed, 10 May 2023 12:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0DAC433D2;
        Wed, 10 May 2023 12:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683720573;
        bh=afxbHdjIrwSj6VNrhj4GIHzNMQeWlMeZcAEhNk8Z57M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jj0npcpEGWo9SJ0UxtXlkb3FWgHyFQL4qPBNOSfzU5rMo2dl7CuGNbqvuEEk2huRi
         JxwhxKZUnM98/IIaGlcsvyLBrlyWXGfdAnb8MOWM5JuVEH16bM3UijBrulznA2DH+e
         YH0ZrlUPPnQX8JuXYwOfCmK7zuqDod8iyrxg55yx3TXTyhIND1XO4wRMpUmQxNPcq6
         FkJCidWUHcnyOl6IlYnUz1tF1dTxfEkLvVf2E8Z7SApGQqRJvxzM/50ZJzwqaqOlXj
         uMDgSTRE5z8CtI0MVyfOzHWSi+t7ZLqPY1R1wA/Sbkc4Vys/Bm/xeCJYkxv0ACIqMP
         i/R4ScVrjyybA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Felix <nimrod4garoa@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        regressions@lists.linux.dev,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: Re: [REGRESSION] wifi: brcmfmac: add firmware vendor info in driver info
References: <4ef3f252ff530cbfa336f5a0d80710020fc5cb1e.camel@gmail.com>
        <c7aa9034-59f8-11aa-7170-86c0db012dda@redhat.com>
Date:   Wed, 10 May 2023 15:09:27 +0300
In-Reply-To: <c7aa9034-59f8-11aa-7170-86c0db012dda@redhat.com> (Hans de
        Goede's message of "Wed, 10 May 2023 12:04:32 +0200")
Message-ID: <87bkiso0aw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> writes:

> On 5/10/23 10:25, Felix wrote:
>> Changes made by the mentioned commit lead to Oops when waking up after
>> suspend to RAM.
>>=20
>> When waking up a Dell XPS 13 9350 with BCM4350 wifi card after suspend
>> to RAM,=C2=A0the kernel hangs with a NULL pointer dereference and Oops. =
The
>> issues was introduced by commit
>> da6d9c8ecd00e20218461007948f2b0a8e7fa242 and only happens when the
>> brcmfmac module is loaded. This issue is the reason we could not
>> upgrade to newer kernels than the 6.1 series on the affected machine.
>>=20
>>=20
>> Details:
>>=20
>> On a Dell XPS 13 9350 laptop with Broadcom BCM4350 wifi card (according
>> to lspci), every kernel starting with 6.2 hangs when waking up after
>> suspend to RAM. The issue persisted as of May 2nd (last tested commit
>> was 348551ddaf311c76b01cdcbaf61b6fef06a49144). Passing the debug and
>> no_console_suspend parameters to the kernel show that a NULL pointer
>> dereference and an Oops happen at wakeup. Please find the kernel
>> messages readable on the screen at this point attached
>> (kernel_log_after_suspend.txt).
>>=20
>> A bisection was successful and produced the first bad commit
>> [da6d9c8ecd00e20218461007948f2b0a8e7fa242]=C2=A0wifi: brcmfmac: add firm=
ware
>> vendor info in driver info
>> I've attached the bisection log as well (bisect.txt).
>>=20
>> Suspend to RAM works on this machine on newer kernels once the brcmfmac
>> module is unloaded.
>>=20
>> Distribution: Arch Linux
>> Architecture: x86_64
>> Device: Dell XPS 13 9350 with BCM4350 wifi card
>> Kernel config used at compilation (created using the Arch Linux default
>> config and make olddefconfig):
>> https://gist.githubusercontent.com/maclomhair/e33fa7eece8f8c77e5a88c4eed=
e2f523/raw/429dfb022498c026225865dbb3ab2f75d5030a54/config
>> Dmesg output after boot:
>> https://gist.githubusercontent.com/maclomhair/47c75fa759d93800e7fb5e937f=
abef3e/raw/10750996a1ea9dcb3fa14d9b94e11fedd3abf280/dmesg
>>=20
>> #regzbot introduced da6d9c8ecd00e20218461007948f2b0a8e7fa242
>
> Thank you for reporting this and thank you for bisecting it too!
>
> As a result of your excellent bug report I've been able to write
> a fix for this. I'm confident enough in the fix that I've submitted
> it upstream right away.
>
> But it would still be good if you can test the fix and let us know
> if it fixes this issue for you. You should have received a copy
> of the patch when I submitted it upstream.

For the archives here's the patch:

https://patchwork.kernel.org/project/linux-wireless/patch/20230510100050.27=
099-1-hdegoede@redhat.com/

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
