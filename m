Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D006223A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 06:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiKIF45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 00:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIF4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 00:56:54 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1872B1EC5A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 21:56:54 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-333a4a5d495so153282187b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 21:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pH5n86V2vlwlF9aXOB/jdhykuMPZm9xt1mr1n2dpOHg=;
        b=ELM5sQOhvtk7Le0mgzSHPBbF3z96SUAiq8PK0ajfCWmpIb1cdD654rA1m9qnx7RqKV
         zSFmZ/fExpnUlyO5cyzCR8zog9DOcSY/EGbTY/lFK/VP8AnviZsGFo0/lardO+V/ovjs
         lMQBPG8dYDBxfMxrtLi8c/APvSA2bzQ2/nq0jIArn/ojKNikHAMbeWVcfK/7MIyxbtoz
         f4Yq/f5dz8eQym+tIVb80tStykSnAwEIsOytmvIAMXW8XOViOv7tijopd1r8pDqbhWjZ
         p35qEjhM/aGhIVhUIf8J2yZXLxxIBbdHn8lDbS1ZEGx6DHc7MxOqsT8RpVN1S7klqbGW
         3l8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pH5n86V2vlwlF9aXOB/jdhykuMPZm9xt1mr1n2dpOHg=;
        b=5PVsOu1uAmmuLYMKLeGjMtZp43+pKwlK4IQ2u63MAK1i92c4fdJelLwffAHKmWxZCZ
         Jy1bRjjc+vjbgjiUDkn/1dsFrb/vtDEm78OiVdY3kAuXRCKirV3qfOn4Vnd4XfDDTQQG
         a+CTT3nXshjnSe5Go23STkZa6dgPV837eMvNe6VoUOh346pwZe7KzFnUO524qerHXNDx
         UXVSFZGfPKnVFoIPWVdufZfCj7GunEkt39rFkdqy7In+fVmvNONjWefmt9m+6yw07W7C
         b6LmOhAo/h5971ECk17BiIpJDk4GvieQ4Pe2esDD/gcH5pB6XJ8L9qRDzK5UDW30ixOt
         jEUQ==
X-Gm-Message-State: ACrzQf2sB3tjMFwLbBM2EucSg73A5nzHvcj11b7buenFhpXHXLIjSZqS
        Z/qI3npPI9ZIGGUtDFWAR+yat4H3jtmYWqBXd8YC9A==
X-Google-Smtp-Source: AMsMyM7KNaOyzNcU3lNn5X4RyNarCGyEBzw/uQ6p1kFKthoIPuKaj+trVfNoLTs76ZOet1dRlhohGqfVYbabrY16D70=
X-Received: by 2002:a81:7585:0:b0:368:28bd:9932 with SMTP id
 q127-20020a817585000000b0036828bd9932mr54776947ywc.332.1667973413067; Tue, 08
 Nov 2022 21:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20221108123320.GA59373@debian>
In-Reply-To: <20221108123320.GA59373@debian>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 8 Nov 2022 21:56:42 -0800
Message-ID: <CANn89iL_0EWCW5Ks6okUKc5579eYg26Z0gffHArgj90YEMSa0A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] gro: avoid checking for a failed search
To:     Richard Gobert <richardbgobert@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        lixiaoyan@google.com, alexanderduyck@fb.com,
        steffen.klassert@secunet.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 4:34 AM Richard Gobert <richardbgobert@gmail.com> wrote:
>
> After searching for a protocol handler in dev_gro_receive, checking for
> failure is redundant. Skip the failure code after finding the
> corresponding handler.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
