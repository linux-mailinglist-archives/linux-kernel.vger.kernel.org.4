Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739BE706D71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjEQP5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjEQP5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:57:14 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252193A80
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:57:11 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f389c519e5so5777871cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684339030; x=1686931030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Izb4CN7Me93wS9J1UlAZhPqaI5E+X4oW/vzIq2l0Vis=;
        b=fAWbSr5MQuSfHuwbfDUZIlGzZ54RJCaFMSaAyUvW9JokG7hVrOtNINhDSV2WaBKbPk
         7zdGjG+clgirhgY0U5bwohvJBcxDdN3tEzwUP51AqazoV6O23DztSgORa8axfnr7jV+N
         qtrOn5GLsLEV9M4pAdaJ5AAiMzm2mGY7E2mmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684339030; x=1686931030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Izb4CN7Me93wS9J1UlAZhPqaI5E+X4oW/vzIq2l0Vis=;
        b=KXTqrgDcWBKsw0EA5xs6GpusLjkYe86HNI4JTww2t7tl+jW0P6SuIMatfDJmMoT9AV
         AY4BMqa4o5h4J9wGp3ZEC74ckNm/Esdr7ZFDINpHXkNtO1pxKbTSmcemtyG9eW6vKwns
         66ukbzGMJOqKUOh6NH08BpQK6cuvqR9GFjnbk/KhpNLfXUhbKpJMKdLncncJVkme82U+
         ZtTGvlD7oakayK/6wVsfRghx6vhMa958Ofg+VACrut3yoOUSaKP1mv7HmFjmpprKkbEL
         XUvpe1kn2WzkNNPZoOdzuEbChyAitX7GU4lXDDM2nXA3TngUUDW2dFKYdLD9XYmjK7z2
         WV0w==
X-Gm-Message-State: AC+VfDzto+eEP2wQW8yz9kBwEcB5BpkAExb+F17FgBSnwq6chW3f9RUh
        rI4CWZeTnxM72eoH7QzWhsFoNKh/Vv7Q8jnVja3lKg==
X-Google-Smtp-Source: ACHHUZ5/rt84bwCwdDlTQ700bAQBPYaCE+UkLZDs1rc6ifaRzmz+ShSpnXg6viaQZQutotCOEdLdTDKDcMS6BBG9EJg=
X-Received: by 2002:a05:622a:102:b0:3f3:95e6:7730 with SMTP id
 u2-20020a05622a010200b003f395e67730mr195478qtw.39.1684339030157; Wed, 17 May
 2023 08:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230515142552.1.I17cae37888be3a8683911991602f18e482e7a621@changeid>
 <ZGQ9Y+vqWhQLHAQh@google.com>
In-Reply-To: <ZGQ9Y+vqWhQLHAQh@google.com>
From:   Tim Van Patten <timvp@chromium.org>
Date:   Wed, 17 May 2023 09:56:59 -0600
Message-ID: <CAMaBtwHxaevxLY7zWNDU8zbyWx=puLkeeRAjFtovvrA5pjtJ4w@mail.gmail.com>
Subject: Re: [PATCH] [v9] platform/chrome: cros_ec_lpc: Move host command to prepare/complete
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, robbarnes@google.com,
        lalithkraj@google.com, rrangel@chromium.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I can understand the patch wants to notify EC earlier/later when the syst=
em
suspend/resume.  But what is the issue addressed?  What happens if the
measurement of suspend/resume duration is not that accurate?

Please see the following:
- b/206860487
- https://docs.google.com/document/d/1AgaZmG70bAKhZb-ZMbZT-TyY49zPoKuDDbD61=
dDBSTQ/edit?disco=3DAAAAws1enlw&usp_dm=3Dfalse

The issue is that we need the EC aware of the AP being in the process
of suspend/resume from start to finish, so we can accurately
determine:
- How long the process took to better gauge we're meeting ChromeOS requirem=
ents.
- When the AP failed to complete the process, so we can collect data
and perform error recovery.

If the EC isn't monitoring the entire process, then:
- We get an inaccurate representation of when the suspend/resume
started/finished.
- The AP can fail during the gaps in monitoring and the EC will be
unable to detect and recover from it.

> It seems prepare() is a more general callback.  It could be followed by
suspend(), freeze(), or poweroff()[1].  Do we expect the change?  For examp=
le,
the system is going to power off but EC gets notification about the system
should be going to suspend.  Same as complete().

Please reference the implementation of SET_LATE_SYSTEM_SLEEP_PM_OPS
and see that we were already calling it in the poweroff path:

#define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
.suspend_late =3D suspend_fn, \
.resume_early =3D resume_fn, \
.freeze_late =3D suspend_fn, \
.thaw_early =3D resume_fn, \
.poweroff_late =3D suspend_fn, \  <<---- here
.restore_early =3D resume_fn,

* @poweroff_late: Continue operations started by @poweroff(). Analogous to
* @suspend_late(), but it need not save the device's settings in memory.

So, there is unlikely to be any functional difference with this change
in terms of poweroff.

> What about other interfaces (i2c, spi, uart)?  Do they also need to chang=
e
the callbacks?

We aren't concerned about those devices, because they aren't being
used on the devices we're seeing issues with. If devices using those
ECs want this change, they can pick it up as well, but we don't have
any way to test changes on those devices (whatever they may be).

On Tue, May 16, 2023 at 8:35=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Mon, May 15, 2023 at 02:25:52PM -0600, Tim Van Patten wrote:
> > Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
> > .prepare() and cros_ec_lpc_complete() during .complete(). This moves th=
e
> > host command that the AP sends and allows the EC to log entry/exit of
> > AP's suspend/resume more accurately.
>
> I can understand the patch wants to notify EC earlier/later when the syst=
em
> suspend/resume.  But what is the issue addressed?  What happens if the
> measurement of suspend/resume duration is not that accurate?
>
> Copied from my previous mail:
> * Should it move the callbacks?
>   * Is it appropriate to call cros_ec_suspend() when PM is still in prepa=
re
>     phase and call cros_ec_resume() when PM is already in complete phase?
>
> It seems prepare() is a more general callback.  It could be followed by
> suspend(), freeze(), or poweroff()[1].  Do we expect the change?  For exa=
mple,
> the system is going to power off but EC gets notification about the syste=
m
> should be going to suspend.  Same as complete().
>
> Moreover, cros_ec_suspend() and cros_ec_resume() do more than just notify=
 EC.
> E.g. [2].
>
> What about other interfaces (i2c, spi, uart)?  Do they also need to chang=
e
> the callbacks?
>
> [1]: https://elixir.bootlin.com/linux/v6.4-rc1/source/include/linux/pm.h#=
L74
> [2]: https://elixir.bootlin.com/linux/v6.4-rc1/source/drivers/platform/ch=
rome/cros_ec.c#L351
>
> > Changes in v9:
> > - Remove log statements.
> > - Ignore return value from cros_ec_resume().
>
> The change logs are not part of commit message.  They should put after "-=
--".
