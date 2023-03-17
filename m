Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7656BEFD2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCQRiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCQRiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:38:01 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C2FC1BFC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:37:52 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r5so6442307qtp.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679074670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQbg/9o4MTLAoU6v0TWceh9IquAie7qBLy1ESoDHYJQ=;
        b=KOI1JmDLdym9kQfsUWrq2pvE3kOYrCkH9Ihr8MduZydaqniYNAJglj+mpP2UVDYn4+
         kW5vSjlVk/DrcJcfkbuRbTALbdKId1jkdm0LAwxjBsd4XA6JlFrDR15+IUc3uRGu74Fz
         KP5ouPkmyrAUKxy+0upMIGKBiEwN7+cqDSEX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679074670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQbg/9o4MTLAoU6v0TWceh9IquAie7qBLy1ESoDHYJQ=;
        b=VwyZf/mD5OpR5n3kgrnE+nqgM8Dm4Mg3E52nA2TmhiYp5T684yulBkzD4XNm5wReoH
         o16E2TxqP3Rq796NIAKbMKULyPmvoKHfgNPiblIM1ALgpV53unjRxp8/oUiMH2FJbh8s
         BiG13jHVmdoFqQhV/qUpm/UvwawhoeFo9rWNZKkjIrJKL0YH64oeQc88ON4gYRgiYZIS
         bgNPAxrDlUGnJRrwmYL06akLaDr40ccwLm+NwMoJzZLAlLdeity+srTENXf/0eOlGOEf
         Yhkt3HHZYyT/mWz7SzBQzNaYxx9ryLX0lR8kXt+6LA1HGmvDHxOvcjLHB23kJHxlWKDn
         PcpA==
X-Gm-Message-State: AO0yUKUB8o9GMbKKM+hafy1T12U5SSgBsIwlQgNXa/0UiyfA+ts5f/r1
        7JV9MCqijB0tsvyaGJS2G2LoCM2MAojvk+eJyl4=
X-Google-Smtp-Source: AK7set/AcJa6xNFq02dCroVPzZ+OMTTBYLjgOIvrrsd1stQQv7ZE1phTQGGdWWWzxKkOm55jYWwQGg==
X-Received: by 2002:a05:622a:118b:b0:3bf:db54:b622 with SMTP id m11-20020a05622a118b00b003bfdb54b622mr14216002qtk.30.1679074670454;
        Fri, 17 Mar 2023 10:37:50 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id h23-20020ac85157000000b003b848759ed8sm1622351qtn.47.2023.03.17.10.37.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 10:37:49 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5416698e889so107414727b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:37:49 -0700 (PDT)
X-Received: by 2002:a81:a704:0:b0:544:bbd2:749c with SMTP id
 e4-20020a81a704000000b00544bbd2749cmr2114862ywh.2.1679074669295; Fri, 17 Mar
 2023 10:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230317171943.941539-1-saravanak@google.com>
In-Reply-To: <20230317171943.941539-1-saravanak@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Mar 2023 10:37:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VM_0_7ymUTsyvXp5COnNN-k9cTN+sKHwRpy1o5PdXeNg@mail.gmail.com>
Message-ID: <CAD=FV=VM_0_7ymUTsyvXp5COnNN-k9cTN+sKHwRpy1o5PdXeNg@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Add CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 17, 2023 at 10:19=E2=80=AFAM Saravana Kannan <saravanak@google.=
com> wrote:
>
> Add a build time equivalent of fw_devlink.sync_state=3Dtimeout so that
> board specific kernels could enable it and not have to deal with setting
> or cluttering the kernel commandline.
>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/Kconfig | 12 ++++++++++++
>  drivers/base/core.c  |  5 +++++
>  2 files changed, 17 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
