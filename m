Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981556ED51D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjDXTLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDXTLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:11:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14A7134
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:11:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ec9c7c6986so5040571e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682363499; x=1684955499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD0Di0Fitz4uA3U0bu+BQKjY/3OPz9pKNYaL+s8xOn4=;
        b=k3h4nmc9zu55vmz/rg9Y1zsKjvuC8usHDIY4bIQxfljinV4PtyASFpMUJ4Xhr9uh66
         p7Z8M344IP9e1DpyLBq1fKwuiBYIXY8Lt+szKOmoxieYTrd8Rhh07QIGGZgu3WvMfG9V
         gIwLbtE32yv3MIkupiFUIxYxKTx7RsgUOpUlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682363499; x=1684955499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wD0Di0Fitz4uA3U0bu+BQKjY/3OPz9pKNYaL+s8xOn4=;
        b=fy6PdVp4aw8o/aOdVG0S436eKtDT+9131w/iVcsTO9vkCxen9lsvhnRRRtd658zGq2
         MQxlxnZmPV/2LY0PYf0mGAIAcsxGGkLLLd9saXU6nHqvHMlUfHn40to1+tyujYVu06gV
         VVSFIold+L6FyidFd4jFlC+ndzfXpDIrRI2zBTDlcz0sBRg62jl6CMwjntTqGmPDEOhI
         OoF/b8iuhcArcw14bWhh6wyYvWDb8P9Gf2az6/PJBTtNzqurt7+QGc7odP6yyPvZKA9Q
         pdg+dbuMs/BJvn2YEMm50M68i7Up+2KfCrn0Q3DkXPCe0fLcIeMxJXc0B/AouFQw81Ms
         9dIg==
X-Gm-Message-State: AAQBX9egm/Ob0+FkkX5+lAxT17DgJEz3SfDIzNhdXPfvD+iUfSWR7j2s
        kBlzNOyvPBj+7FkJH+ZnUh1DEoJrY5fRS950TCLDcg==
X-Google-Smtp-Source: AKy350YQIW7VVLVLVr9A6il9z434/BheTBBSm4idTXqokyJ5uGRdnFKUUfzhamKa6zz53OpZDMtbtFYDlYvH6S7nefw=
X-Received: by 2002:a19:f509:0:b0:4dd:a73f:aede with SMTP id
 j9-20020a19f509000000b004dda73faedemr3102210lfb.10.1682363499182; Mon, 24 Apr
 2023 12:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <063c8f77c216ffac463532023009124542d54c19.camel@redhat.com>
 <20230414092353.v2.1.Ieb687047a5b75c7b7ee5dd258207ef5ca9a3b728@changeid>
 <CALNJtpXLHHSV8YshUnk0opLNMUJpT7DgBNRYXoP2Yn-fnA8vPA@mail.gmail.com>
 <CALNJtpV4WsknSSfBBer-MM0y_V=O5Fv2Lc3ei3heEyZwvR2rzQ@mail.gmail.com> <65C23A49-5A55-4CF4-9AFD-2DA504DAABF5@duggan.us>
In-Reply-To: <65C23A49-5A55-4CF4-9AFD-2DA504DAABF5@duggan.us>
From:   Jonathan Denose <jdenose@chromium.org>
Date:   Mon, 24 Apr 2023 14:11:28 -0500
Message-ID: <CALNJtpWOPRB3-0Jw+GJt_D-vjEhbhDRw-Kb3boC0dOU+525fFQ@mail.gmail.com>
Subject: Re: [PATCH v2] Input: synaptics - disable intertouch for Lenovo L440
To:     Andrew Duggan <andrew@duggan.us>
Cc:     Lyude Paul <lyude@redhat.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        "amandhoot12@gmail.com" <amandhoot12@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "jdenose@google.com" <jdenose@google.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "markpearson@lenovo.com" <markpearson@lenovo.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        benjamin.tissoires@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for your reply. As an update, I was able to try the patch here:
https://lore.kernel.org/all/YgHTYrODoo2ou49J@google.com/ and it
resolves the suspend/resume issue on this device. I'm not sure what
the status of the linked patch is, to me it doesn't look like it was
merged anywhere.

On Mon, Apr 17, 2023 at 3:14=E2=80=AFPM Andrew Duggan <andrew@duggan.us> wr=
ote:
>
> Hi Lyude and Jonathan,
>
> I was just about to reply and suggest that we look into this issue a litt=
le more since the touchpad in the L440 would benefit from the additional da=
ta from the intertouch interface. Especially, since it has a large area and=
 several buttons. PS/2 only reports position data for two fingers so three =
finger gestures is another example.
>
> Generally, these types of suspend / resume issues are the result of the t=
ouchpad resetting and the firmware expecting commands from the PS/2 interfa=
ce. On resume, the PS/2 driver should send a command over the PS/2 interfac=
e to switch the touchpad firmware back into intertouch (SMBus) mode. The lo=
gs you provided look like that's what is happening here. The SMBus driver i=
s sending commands, but the touchpad firmware won't respond until it is swi=
tch back into intertouch mode. It has been a while since I have worked on t=
hese touchpads, but from what I remember I think there is code in the psmou=
se-smbus driver to handle these situations. I added Benjamin Tissoires to C=
C since I think he worked on that handling. I thought suspend / resume was =
tested on with these "top button" touchpads when support for them was added=
. I don't know if the L440 specifically included in the testing. I'm curiou=
s if this is a regression or not.
>
> Regarding the patch, I do have one comment below:
>
> > On Apr 17, 2023, at 11:52, Jonathan Denose <jdenose@chromium.org> wrote=
:
> >
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >
> >
> > Sorry, I thought I sent this as plain text but I think maybe not.
> > Trying once more, the message was:
> >
> > I think that disabling synaptics_intertouch would resolve the issue
> > mentioned in the commit, but cause a regression in the functionality
> > that intertouch is supposed to bring, like three-finger gestures. I'm
> > attaching some of the logs that I captured when the touchpad was
> > failing on resume. I think the main culprit is
> > i2c_smbus_read_byte_data where the driver is unable to get the SMBus
> > version number. I get the following lines in dmesg:
> >
> > [ 2869.745860] rmi4_smbus 0-002c: failed to get SMBus version number!
> > [ 2869.746060] rmi4_physical rmi4-00: rmi_driver_reset_handler: Failed
> > to read current IRQ mask.
> > [ 2869.746260] rmi4_f01 rmi4-00.fn01: Failed to restore normal operatio=
n: -6.
> > [ 2869.746262] rmi4_f01 rmi4-00.fn01: Resume failed with code -6.
> > [ 2869.746264] rmi4_physical rmi4-00: Failed to suspend functions: -6
> > [ 2869.746265] rmi4_smbus 0-002c: Failed to resume device: -6
> > [ 2869.746268] rmi4_smbus 0-002c: rmi_smb_resume+0x0/0x6b [rmi_smbus]
> > returned 0 after 549 usecs
> > [ 2869.746446] rmi4_physical rmi4-00: Failed to read irqs, code=3D-6
> >
> > Any ideas on what might be causing this, only on resume from deep sleep=
?
> >
> >
> > On Mon, Apr 17, 2023 at 1:47=E2=80=AFPM Jonathan Denose <jdenose@chromi=
um.org> wrote:
> >>
> >> I think that disabling synaptics_intertouch would resolve the issue me=
ntioned in the commit, but cause a regression in the functionality that int=
ertouch is supposed to bring, like three-finger gestures. I'm attaching som=
e of the logs that I captured when the touchpad was failing on resume. I th=
ink the main culprit is i2c_smbus_read_byte_data where the driver is unable=
 to get the SMBus version number. I get the following lines in dmesg:
> >>
> >> [ 2869.745860] rmi4_smbus 0-002c: failed to get SMBus version number!
> >> [ 2869.746060] rmi4_physical rmi4-00: rmi_driver_reset_handler: Failed=
 to read current IRQ mask.
> >> [ 2869.746260] rmi4_f01 rmi4-00.fn01: Failed to restore normal operati=
on: -6.
> >> [ 2869.746262] rmi4_f01 rmi4-00.fn01: Resume failed with code -6.
> >> [ 2869.746264] rmi4_physical rmi4-00: Failed to suspend functions: -6
> >> [ 2869.746265] rmi4_smbus 0-002c: Failed to resume device: -6
> >> [ 2869.746268] rmi4_smbus 0-002c: rmi_smb_resume+0x0/0x6b [rmi_smbus] =
returned 0 after 549 usecs
> >> [ 2869.746446] rmi4_physical rmi4-00: Failed to read irqs, code=3D-6
> >>
> >> Any ideas on what might be causing this, only on resume from deep slee=
p?
> >>
> >>
> >> On Fri, Apr 14, 2023 at 11:41=E2=80=AFAM Jonathan Denose <jdenose@chro=
mium.org> wrote:
> >>>
> >>> When intertouch is enabled for the L440 a (deep)sleep/resume
> >>> cycle causes the touchpad driver to hang which causes the
> >>> touchpad to become unresponsive. Disable intertouch resolves
> >>> this issue and the touchpad is fine after resume from sleep.
> >>>
> >>> Additionally, when the PNP id for the L440 is only removed
> >>> from the topbuttonpad_pnp_ids list, a message is logged to
> >>> enable psmouse.synaptics_intertouch, which would cause the
> >>> sleep/resume issue again. By removing the PNP id from
> >>> topbutton_pnp_ids and then adding it to the
> >>> forcepad_pnp_ids array, intertouch is disabled and the
> >>> message is not logged.
> >>>
> >>> Signed-off-by: Jonathan Denose <jdenose@google.com>
> >>> ---
> >>>
> >>> Changes in v2:
> >>> - remove debug statement
> >>>
> >>> drivers/input/mouse/synaptics.c | 2 +-
> >>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/sy=
naptics.c
> >>> index fa021af8506e4..b7218b7652c20 100644
> >>> --- a/drivers/input/mouse/synaptics.c
> >>> +++ b/drivers/input/mouse/synaptics.c
> >>> @@ -150,7 +150,6 @@ static const char * const topbuttonpad_pnp_ids[] =
=3D {
> >>>        "LEN2001", /* Edge E431 */
> >>>        "LEN2002", /* Edge E531 */
> >>>        "LEN2003",
> >>> -       "LEN2004", /* L440 */
> >>>        "LEN2005",
> >>>        "LEN2006", /* Edge E440/E540 */
> >>>        "LEN2007",
> >>> @@ -198,6 +197,7 @@ static const char * const smbus_pnp_ids[] =3D {
> >>> static const char * const forcepad_pnp_ids[] =3D {
> >>>        "SYN300D",
> >>>        "SYN3014",
> >>> +       "LEN2004", /* L440 */
>
> While this does seem to elliminate the message, the touchpad in the L440 =
is not a forcepad. Adding the L440 PnP ID here implies that it is one of th=
ese special forcepads which reports "force" data for contacts and that is n=
ot the case here.
>
> >>>        NULL
> >>> };
> >>>
> >>> =E2=80=94
> >>> 2.39.2
> >>>
>
>
> Andrew
>
