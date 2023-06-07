Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1F6727324
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjFGXiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjFGXiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:38:04 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FAC2D4A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:37:40 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-33d0b7114a9so10426425ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181058; x=1688773058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN7QCcXv3GhQ50KYCOkYuc7v8/KdYJA2Wdn7x5ACZBs=;
        b=F5C6nzp+cNI2MtG6/XKmmxvpCjcrpQXH9zwlDATsZqNr8TW2LkR5B5hZZnVTvszt8a
         XEpY1dYF6O2AXOt/RpjVrgZVJDJuYH4uyvm8nPSggRNzzSZ9YepME8o6ia4wAi4uEdSm
         qadmXlE7AclTcZYJr/sk15VQxc5UkWahO7/K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181058; x=1688773058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN7QCcXv3GhQ50KYCOkYuc7v8/KdYJA2Wdn7x5ACZBs=;
        b=Hjy6hKlSXz9DwL0jSZ+sqJK7oiya+i0Nhur2VvO05NHkKAQxMror5RasAsfqLzglzu
         KrOyKQlUeES1TnSALcnGL1DoSSEHoKSrI5wuL2+2ivgJHdaRqncgcxHsgEiohOxZscFC
         xaLZ2IHeO++/B3ow9p6i3AivWcZCBIgfQNnK6RmREg0jo96w9v8BmXFiHVo7o2Lre9Mp
         CloxJRNP9u9Ih9pZRFunMnjFibn7DUf+X6Jb8mIJVljvzQoB2rZU+6zwLjw0+YH3JWH5
         QY4AbMMq4Bjger6fWJGqzkbjNWpIaocxCxGPglEt+D3HCyyVP30K8a5pai1a9Eet7Ykw
         AvPg==
X-Gm-Message-State: AC+VfDxUD8e1rEg+NNvJILACR75LmL0zjXgweVBYaESE81IJo5InWvDO
        qQ+TjySgSUpo7ekBFu3I1zargMtWUIgFqMhpCxA=
X-Google-Smtp-Source: ACHHUZ5qy/iQN6+qCTnlD8uJ7XWbkRGcBb8D/mhdHXr4rIRFQgTfvS+pgYgouHPXZXvctizLvtynAA==
X-Received: by 2002:a92:d411:0:b0:33b:7e4:167a with SMTP id q17-20020a92d411000000b0033b07e4167amr10229902ilm.15.1686181058206;
        Wed, 07 Jun 2023 16:37:38 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id z18-20020a029f12000000b0041a9c4e0f1csm3716478jal.109.2023.06.07.16.37.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:37:34 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-33d928a268eso54825ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:37:32 -0700 (PDT)
X-Received: by 2002:a92:c54d:0:b0:33e:6b65:6f78 with SMTP id
 a13-20020a92c54d000000b0033e6b656f78mr16557ilj.27.1686181051931; Wed, 07 Jun
 2023 16:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-1-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:37:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W=xamTf6BUmp-Yg-SEEgE8GRKw6Pnfv6t=Hviywj-N-g@mail.gmail.com>
Message-ID: <CAD=FV=W=xamTf6BUmp-Yg-SEEgE8GRKw6Pnfv6t=Hviywj-N-g@mail.gmail.com>
Subject: Re: [PATCH 0/7] watchdog/hardlockup: Cleanup configuration of
 hardlockup detectors
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 7, 2023 at 8:25=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> Hi,
>
> this patchset is supposed to replace the last patch in the patchset clean=
ing
> up after introducing the buddy detector, see
> https://lore.kernel.org/r/20230526184139.10.I821fe7609e57608913fe05abd8f3=
5b343e7a9aae@changeid

I will let Andrew chime in with his preference, but so far I haven't
seen him dropping and/or modifying any patches that he's picked up in
this series. I see that he's already picked up the patch that you're
"replacing". I wonder if it would be easier for him if you just built
atop that?

-Doug
