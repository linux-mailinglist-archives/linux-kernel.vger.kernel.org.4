Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FBD74E18B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 00:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGJWql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 18:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGJWqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 18:46:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813CC1B7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:46:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e34ad47eeso6434070a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689029195; x=1691621195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kc719wFeXIBZhxeGvf3Y+MTcIYRnee7N32RFrCgfHE=;
        b=DriSoHTaq8DDYG2ENp0wwmb3Z5QUSPyxY5SrE6+6Z51k9KtqcUJjP47DLF6CY71G5V
         jkjmQQu/2D6Jc9CNxE/lIpI4HgIbPOBnMVY/iD0+0CZ9Ti3XBt2bZQKhEtQq8xU5QJn9
         FaqtQvrTXHosqcXJk7njxc7ttpsNynZT3EWpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689029195; x=1691621195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kc719wFeXIBZhxeGvf3Y+MTcIYRnee7N32RFrCgfHE=;
        b=b2hggrcRql5mVDOeusNDTpzEGDh5iM966xteYX5llLfdEenmP8t9LIHjX61fVmORKk
         wcC3olm+SgNGnKwaXOFM5fhNNcG6L/R+waUdPF/y3X/vq28/0s1RSzv17Io8DbFl79pV
         Wcl4Dkj5h/ScRl7yGfaM7VSngkzoLHuonJwVdpyZWzj31RzhqmMf8M5IxMpcZt/tEbS6
         KjZ/O7HTJz4NPzEyYarNeAOJU+TEf2dja7VkeqaXclG/u86LhKCnqBCguDe4gRP05ysw
         BbdbkxR1h4tLPFtLxvZJgSMQB3JyEtPIXsvZkVS5UnN6YGeStanuD8aWR6bTVJRUggYh
         cuMA==
X-Gm-Message-State: ABy/qLb2esfnx6ckaC3VkIok05cwSOtHp9Ql3xoyG1eDv0DQsTuOsifr
        SCcRTyLqZBVH74T3ORQW9wfPbXvSwYx14d6FtfE=
X-Google-Smtp-Source: APBJJlFhmT878B0N3lOI6m6bB8lHFyt6tnhCmlg1yYbETESUN5L38gR37yRqtP2fdwx8qGRImx+j8w==
X-Received: by 2002:aa7:d045:0:b0:514:96f9:4f20 with SMTP id n5-20020aa7d045000000b0051496f94f20mr12103564edo.41.1689029194206;
        Mon, 10 Jul 2023 15:46:34 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id k2-20020aa7d8c2000000b0051e2809395bsm262181eds.63.2023.07.10.15.46.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 15:46:33 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-98de21518fbso657920266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:46:33 -0700 (PDT)
X-Received: by 2002:a17:906:242:b0:993:ce6c:685c with SMTP id
 2-20020a170906024200b00993ce6c685cmr14230852ejl.18.1689029192682; Mon, 10 Jul
 2023 15:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230702195057.1787686-1-sashal@kernel.org>
In-Reply-To: <20230702195057.1787686-1-sashal@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 10 Jul 2023 15:46:21 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMZ_ZnJfpsY-8ZRByiox8HCSZeY08MvGSpznLYBtVR1bw@mail.gmail.com>
Message-ID: <CA+ASDXMZ_ZnJfpsY-8ZRByiox8HCSZeY08MvGSpznLYBtVR1bw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.4 01/12] platform/chrome: cros_ec: Report EC
 panic as uevent
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rob Barnes <robbarnes@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>, bleung@chromium.org,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 2, 2023 at 12:51=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Rob Barnes <robbarnes@google.com>
>
> [ Upstream commit 2cbf475a04b2ae3d722bbe41742e5d874a027fc3 ]
>
> Create a uevent when an EC panic is detected. This will allow udev rules
> to trigger when a panic occurs. For example, a udev rule could be added t=
o
> capture an EC coredump. This approach avoids the need to stuff all the
> processing into the driver.
>
> Signed-off-by: Rob Barnes <robbarnes@google.com>
> Reviewed-by: Prashant Malani <pmalani@chromium.org>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Link: https://lore.kernel.org/r/20230509232624.3120347-1-robbarnes@google=
.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/platform/chrome/cros_ec_lpc.c | 3 +++
>  1 file changed, 3 insertions(+)

What sorcery determined this was a valid for-linux-stable patch? It's
a new feature, and definitely not a for-stable candidate. Please
remove this from the queue.

Brian
