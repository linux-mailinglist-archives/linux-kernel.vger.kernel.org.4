Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263CC7233F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 02:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjFFAID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 20:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjFFAIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 20:08:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAB0FD;
        Mon,  5 Jun 2023 17:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17B1F62607;
        Tue,  6 Jun 2023 00:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61402C433EF;
        Tue,  6 Jun 2023 00:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686010080;
        bh=wpeSJUE5QEvFvZzvYO7sZqyorFppcAZOUTc84L3tFCI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BG/FmoU//ibDu795ITfA6MsApJDi1/9mSw7ndJ/XWisFIdggLUH37f5fO0jqCByyE
         e9q0oQCM4jeK81z1vgjcPNjK649lljorBFq6H1To/0RFYfHlB02BG2kUH8oK9M4InV
         ra9upkMWHGVYdGcf7TfpjdwAmRq4M+VabGfo4xJmhh/cn8vdAM+UxIkZ87R3F9d2vY
         /LI2hhYwtMI13AtP5PR9/EkRZI/7R8AU9mjoQfozjWT2IJbEBeoUh7jGbQL3QubxTQ
         YshfQvVxcZ7yX6uOueglZX/CNwvB3ncbzBeEjNyA4UiryYF1Sx0G2jUi0vTUJvusLF
         cVLkp1eayBJew==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4effb818c37so6836990e87.3;
        Mon, 05 Jun 2023 17:08:00 -0700 (PDT)
X-Gm-Message-State: AC+VfDxL2o8ZDcsIFcjLt9Skzt/KgvBcKMkvILIvpOR+C8TH4/zsaWwl
        VqQ7oHsKXus27V06vOOP4Xf0nPRAEtM1A/90S6Q=
X-Google-Smtp-Source: ACHHUZ4ZVGiL4jJdnFd4wLN6tDyvtSbWfHE1VBy/hxyNjsO5/GhsdlLQUzqS8cYUSOneZdzV9tZDOc6rm6XPDWR4khs=
X-Received: by 2002:a19:c512:0:b0:4ec:9ef9:e3d with SMTP id
 w18-20020a19c512000000b004ec9ef90e3dmr245870lfe.26.1686010078423; Mon, 05 Jun
 2023 17:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230602091839.743798-1-linan666@huaweicloud.com>
In-Reply-To: <20230602091839.743798-1-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 5 Jun 2023 17:07:46 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4y5AafocO9imHOVbTteiWMdPFh0QrS6KmFMsMvHCvvtw@mail.gmail.com>
Message-ID: <CAPhsuW4y5AafocO9imHOVbTteiWMdPFh0QrS6KmFMsMvHCvvtw@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] raid10 bugfix
To:     linan666@huaweicloud.com
Cc:     neilb@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 2:22=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> Changes in v7:
>  - in patch 1, change "fail" to "fails".

Applied v7 to md-next.

Thanks,
Song
