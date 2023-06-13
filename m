Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5784E72DB07
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjFMHeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjFMHds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:33:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41A31730
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:33:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5149e65c244so7235724a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686641625; x=1689233625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOj+b+v3wCNe+kI49zepTRDruNHDk16kXJ4DGLQYzEg=;
        b=WuiZs2vsum/c+L7UptQ1ey6c3dDEd2i3Gn4IctiNR25SQOFM+f8b9PTdXqyA8gWF5Q
         isR4NN+ux119Av7a552xhPBpzcRie2/XRAOXwZ3bGRcsAPFZAKugn34qSyeybNRIhIW/
         QiXxHl7MTcuogVI60o8WfVrLu5zv9pcnwSO9j0h1Rr0AKUZmo63pP/QOMDVwguqi/roH
         wG9eSSLEGWgo4JUnIPPeCamDGqKkAjF3iKhDbLJpqCYKUieWbvcJIvuee2yNHAfLx+H2
         LZ1j6yE8V2ZmdcZp8zLIm143v9SBA+kHg7oKSBLxmlb+KRdemwnODe0zB2wuIRlLKOvS
         qCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686641625; x=1689233625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOj+b+v3wCNe+kI49zepTRDruNHDk16kXJ4DGLQYzEg=;
        b=k1sHsmqPQJSrZS9P1BHlUYYR3e0OjZ1dUzvaEoPpuZWNFxRRkBKGS9fsdTGExheZs9
         qnoXPJHcU2iNYaRt1CeztUNeE0pCbrKs5AEgyQtaWYXY4Ppp3FdC+2VVOIqzTFs5hdjT
         xFdQsGCm1B6b4i/iCN234/Uw+2fLYky55OKEKKgQcVkK9dmTz+rAYX30tn2rskPto+pW
         jqHI/lFKNJxjBIWg3JwnYJ3SkLsyJOU90j24+MpJPWQiMXsMU4LkTANkmTudQpODuBur
         h2C5yFNCceB0SnXtIgpuLTO/+g+zRmwCfcln2aeYfMvc9Sd6bTqWAHiVUelFLkM5i29T
         SI0Q==
X-Gm-Message-State: AC+VfDxI+wM8vdTyS+phYgXnhuO9TeMMvpH9f8Khjh8NF7Z9KFrfB0PX
        /o3CupCMdR2yK7i8UN2e0CM=
X-Google-Smtp-Source: ACHHUZ5EwL5fueJ7a/Dj6vRcMs3w65CMYX4EbEvr2KBLD5NAzwVM2Rkk2Za89E07G7MzSE73tQU2UQ==
X-Received: by 2002:a50:ed05:0:b0:518:73bb:b64f with SMTP id j5-20020a50ed05000000b0051873bbb64fmr874699eds.28.1686641624634;
        Tue, 13 Jun 2023 00:33:44 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u13-20020a50eacd000000b005149b6ec1bdsm5991683edp.29.2023.06.13.00.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 00:33:44 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     mazziesaccount@gmail.com
Cc:     DLG-Adam.Ward.opensource@dm.renesas.com, bbara93@gmail.com,
        benjamin.bara@skidata.com, broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH RFC v3 1/5] regulator: move monitor handling into own function
Date:   Tue, 13 Jun 2023 09:33:16 +0200
Message-Id: <20230613073316.1984750-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5584a484-df7f-b927-9701-33dcea6230d0@gmail.com>
References: <5584a484-df7f-b927-9701-33dcea6230d0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti!

On Wed, 24 May 2023 at 09:28, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> I am thinking that maybe the default should still be to not touch the
> monitoring unless explicitly requested.

Got it - I will bring back the "mon_disable_reg_disabled" property. With
this property, the current behaviour will be in-place.

> My thinking is that the hardware should by default be able to handle
> the voltage change / enable / disable etc while monitoring is enabled.
> Hardware which requires explicit monitoring disabling sounds (to me)
> like a 'design problem' and disabling the monitoring sounds (to me)
> like a workaround. I wouldn't make this workaround default.
> Furthermore, monitoring is a safety feature, and as such core should
> not autonomously disable it (unless such behaviour is requested).

I totally agree with you here. However, there are regulators that
require such workarounds (e.g. bd718x7 and da9063) and that's the reason
for this series.

> I was thinking of a case where regulator state is not readable - I'm
> not 100% sure how core thinks of their state.

AFAIK, they would be considered as always on. But as Mark said, we could
add this as a requirement for having protection.

> Another case could be a regulator which is not registered to the core
> but shares monitoring with some other regulator. 

I think this case should be handled by the driver anyways. Activating a
shared protection on one regulator, without activating it on the other
regulator should be considered as an error in my opinion.

> If I didn't misread the code, the differences here are that existing
> "ideology" is to a) only touch the monitoring (enable/disable) when
> explicitly requested for a given level and b) knowing that all
> monitors that are requested to be enabled are enabled at the end of
> the probe.
>
> In my eyes change a) is problematic. For example, if a board using
> BD9576 wants to have protection disabled via device-tree (let's assume
> there is a board where we know that some disturbance to voltages will
> occur under specific conditions) - it is very valid to complain
> disabling protection is not supported. 

Yes, I think so too. I would not give the BD9576 any new "workaround
property", which would lead to the behaviour which is currently
implemented, meaning the monitoring is not touched after initialization.

> Go fix your board design message needs to be given because protection
> can't be disabled. This is very different from case where we just try
> disabling monitoring because regulator is turned off. In latter case
> with BD9576 the failure to disable protection should just be silently
> ignored. When we use same callbacks for both the initial configuration
> and the runtime enable/disable/voltage-change handling the driver has
> no way knowing if this is an error or not.

Got it. I am aware now that there are PMICs which do not allow to turn
off the monitor, therefore the default behaviour will be the same as
now. For now, only the da9063 (invalid state when monitoring a disabled
monitor) and the bd718x7 (invalid state when monitoring an enabled
regulator that switches to a higher voltage) are affected by the new
properties. The others which currently have {O,U}VP (max597x, bd9576)
should stay the same as now.

> Therefore, I will switch back to only do it when the monitor
> configuration for enable/disable/voltage-change should be done via
> separate driver callback - that would allow driver to separate these
> use-cases. If this was change I wrote, I might try creating separate
> driver callbacks for
> enable/disable/voltage_change_start/voltage_change_done which get the
> initial monitor configuration (as was read from device-tree) as an
> argument. Do you think that could give the flexibility to handle all
> different hardware quirks?

I think it would, yes. But I also think that it will lead to a lot of
duplicate code. However, instead of a simple "enable/disable" property,
we could reuse the "type of protection" too, to create some kind of
matrix. Example: Instead of setting mon_disable_reg_set_higher to 1 for
the bd718x7, we could set it to REGULATOR_MONITOR_OVER_VOLTAGE, meaning
just this protection should be disabled while switching to the higher
voltage. What do you think about that?

> The change b) does also have consequences. Some PMICs like the BD9576
> do use same IRQ for indicating either ERROR or WARNING level problem.
> Whether to use WARNING or ERROR is selected at star-up when the
> device-tree flags are read. Eg, the .set_<XXX>_protection callbacks
> store the severity information (WARNING or ERROR) and complain if both
> are tried to be used. With the current approach we know the validity
> of this configuration is checked right when regulator is registered,
> not later at runtime when regulator is enabled.

Not sure about that, but I think it would fail to register the
regulator? In this case, later it would not be able to enable it because
it is not registered, right?

> Another example regarding design that uses the knowledge that all
> requested monitors are enabled when regulator is registered is BD96801
> - which is not upstream (although I've had patches in my outbox for an
> year already waiting for permission from the HQ to actually send
> them... Don't ask...). This PMIC can configure fatality of the fault
> monitoring. This driver checks that all regulators did agree on
> whether to use PROTECTION or ERROR/WARNING level monitoring at the end
> of the probe - and toggles the IRQ fatality accordingly. I truly
> believe that out-of-tree drivers must not mandate upstream design -
> but I equally believe that we may see similar HW designs in upstream
> and considering this now makes sense :) Yes, in order to paper over b)
> a driver can for sure go and parse all the monitoring properties from
> device-tree itself and decide things based on that - but it might be
> quite a lot of duplicated code.

From my point of view, the behaviour will stay exactly the same! If they
don't agree on the same level, the probe should actually fail and the
regulators should not be registered. 

> To sum up my view - I do definitely like the idea that core supports
> toggling the monitors for duration of enable/disable/voltage-change as
> this is needed by some real world ICs.
>
> I, however, think drivers should be able to separate the "set the
> default monitoring config" request from the "change config to
> something we use for duration of this operation" - because the best
> monitoring config that is required for an operation may not be a
> "disable all". Hence, we should leave it for the driver to decide what
> config to set for the duration of an
> enable/disable/voltage_set-operation.
>
> Furthermore, I believe the default should be "don't touch the
> monitoring" and not to try disable/enable it w/o explicit request.

Yes, I will definitely keep that in mind and implement it like that in
the next version.

> Again, thank you for working on this and including me in the
> discussion :)

Thanks for your valuable feedback!

Best regards,
Benjamin
