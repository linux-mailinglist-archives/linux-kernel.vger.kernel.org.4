Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C439F6B7F70
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCMRZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMRZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:25:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEEC29E24
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:25:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id kb15so12794409pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112; t=1678728241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yz8oEDJ/77aW7LqMjEdCVKI+U4V++estSGqzJEv2OnU=;
        b=cPxndz4sfLJJO1DZqFSdQkF5BX3CtrNw1Vz+i3PiIWk8TFTmtX0nKa42ZGBPj5qjGa
         Z6MhjZOlTikIFsaRwavWseNjhMZFpgI5JztqgSlJG1YTnuaDsfTuaQRixrGJ8roZpw7v
         tmRKhK9WPGZU8NYBk9eWU72S61E/iU9zaxepedy/8hK2Kyr6KEfphokkeYkX8rYN5Sms
         PQ4+s5WPZ8HpoLfMXS3n0cJBvWJ+fFsJDxWW7hf4SQAdMLl9MurR/druscKS/vnp8Tnn
         H/IWgXIY4Orr3ov18QfAk1Ac6r21Uv9ZOXldmCDMbtoObSufuPkbY5wdL6QQrac8aEB3
         bxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678728241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yz8oEDJ/77aW7LqMjEdCVKI+U4V++estSGqzJEv2OnU=;
        b=G1Px56GDcuh0XNvx6XyjTU/lGDkNZHkdGF3UTuBl6DjjWTS+CFO+9Ab7McA3P+C9O1
         XIdNmeGil/TJyN9pzZjAVCaVvxMgF34xY3HFRqavugd9d3hoE2lwLjuvhrrFDk2Kqk1S
         uYJdqFXk8ns4hCq18+4sQZUs4si2Kn+qQi9o2yfJE8BSKH5A6RTbRe1oeH2rwO44VvcP
         l2ivpKk0HW1jpHDRVhnxNp2EX3ZX7KHJRfoPZ4xTgDzURgXYLfSHB9fx/YGFFg9devrO
         xTW2yK0huKqc6P0CrrZhMvoRng0Py01vrnpxEIEMCP6rrT9ACuPMJsWdYKuyeQtUFtIW
         bh9g==
X-Gm-Message-State: AO0yUKUIXRsi3dv/AmdVgqghItLBEFSBgK9Eo6m4g9HHOG+UcrYsra3C
        SlvZifXA2zHgdNqUYpGNoTyJkg==
X-Google-Smtp-Source: AK7set9QbA7y6ovAucuBjySPyqrEcVGNWMeLrhWXx5qC8VEUXFp8CTDJ9svRmraSTw+rMt43+gW6ew==
X-Received: by 2002:a05:6a20:3d02:b0:bc:42f9:6b21 with SMTP id y2-20020a056a203d0200b000bc42f96b21mr43192268pzi.15.1678728241100;
        Mon, 13 Mar 2023 10:24:01 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id t14-20020a62ea0e000000b005d3901948d8sm9500pfh.44.2023.03.13.10.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 10:24:00 -0700 (PDT)
Date:   Mon, 13 Mar 2023 10:23:59 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jorge Merlino <jorge.merlino@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] Add symlink in /sys/class/net for interface altnames
Message-ID: <20230313102359.7054d058@hermes.local>
In-Reply-To: <20230313164903.839-1-jorge.merlino@canonical.com>
References: <20230313164903.839-1-jorge.merlino@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 13:49:03 -0300
Jorge Merlino <jorge.merlino@canonical.com> wrote:

> Currently interface altnames behave almost the same as the interface
> principal name. One difference is that the not have a symlink in
> /sys/class/net as the principal has.
> This was mentioned as a TODO item in the original commit:
> https://lore.kernel.org/netdev/20190719110029.29466-1-jiri@resnulli.us
> This patch adds that symlink when an altname is created and removes it
> when the altname is deleted.
> 
> Signed-off-by: Jorge Merlino <jorge.merlino@canonical.com>

What about if altname is changed?
