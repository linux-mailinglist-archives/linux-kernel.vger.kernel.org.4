Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7285669FB71
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjBVSqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjBVSqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:46:19 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8822D7E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:45:37 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1720433ba75so11228506fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uMFWkfYuZ+XsQ/RW5Q/H+9yxE1eeW1/UMaA6UQW9FRk=;
        b=WJ9WcTYPOd+/YeHTdtphgt2Fo5wduO3XThXUr0ynUiXiQDBlgJXEo5rb0RATPLhVFm
         XDJNDdkbHYZ04SqqggIuEfL2+AzrA8s1WxYVcGN8Z6J8ZFCL3JYWZlnCUsdnflLe9PVG
         S7ij9ehPkZeo4VB6KJ5f2iLkY5MpCOWNvj0szuUjKHlKaEL7jPNpU09v8EiGXgKyBsKq
         xEDRp3dF/dFVZF2BPTR/W2hzhqTZAZirARjNytlcjdenUF1JqCA8YvG9Qxha5uqxNMvC
         Es8FdlVJ9/f03HQDrqvuDKl/z7zpuieSwCKZjw3ldALPLznfE6UGP94uooIO7ovyL4Ko
         S76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMFWkfYuZ+XsQ/RW5Q/H+9yxE1eeW1/UMaA6UQW9FRk=;
        b=RTJWr3aZqBoOsVxUE5KmwB1v1L4MsDd/MeAdhET+fY0of+HLEwlwVE1cYI01qyUj6r
         8s3ilmdpRrYGsCCjihgEOhqdv+x3D/QrrS7YDvq59b2pPcp+3KmoQ4FNZ6Agvh8FzFO7
         haMVPCpK+0K3ed9Rk8W63M2kgxezKul5dSYAmtzQdqGUnKWdVSK2gajGmihPoRXYKe4y
         +hprmfEPIPz1d2XsH3+fiLdFnnJAPoeA6305dCL3gQs9oYpAg2jaFqpktoSUntiIljwd
         XEF06JxP9ZzvbKEni0N8iGNA3WeFIoqhnrNI6iDxj8hJeml11yN8xS3GBlOHmQq7GbcH
         7U5g==
X-Gm-Message-State: AO0yUKVICbQ2ihb7dKXuZR76WtfAJuSChLGkxP7vRd282rzTJCpCrf/j
        3++jQxwoYFw+Z3et9e4yhBUMjWXMoymWEZsoUPbFYQ==
X-Google-Smtp-Source: AK7set8APk8r2qxx34EP7woOLA19L1Dvu/KebzEGebLqWzFbjDFzsgcGUif9arfZslcjcNAPC5kKBx3Rt+ZhzO2A58U=
X-Received: by 2002:a05:6870:14d2:b0:16e:30ac:b7a1 with SMTP id
 l18-20020a05687014d200b0016e30acb7a1mr1456284oab.44.1677091460998; Wed, 22
 Feb 2023 10:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20230222000915.2843208-1-jiangzp@google.com> <20230221160910.kernel.v1.1.If0578b001c1f12567f2ebcac5856507f1adee745@changeid>
In-Reply-To: <20230221160910.kernel.v1.1.If0578b001c1f12567f2ebcac5856507f1adee745@changeid>
From:   Zhengping Jiang <jiangzp@google.com>
Date:   Wed, 22 Feb 2023 10:44:09 -0800
Message-ID: <CAB4PzUp327-efiARXhsE6Ep+1Lf2T501CexBqhWAhPzMQiEYVQ@mail.gmail.com>
Subject: Re: [kernel PATCH v1 1/1] Bluetooth: hci_sync: clear workqueue before
 clear mgmt cmd
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org, mmandlik@google.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
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

Hi,

We need to revise this patch after a local test failure. I will update
after finding the cause.

Thanks,
Zhengping

On Tue, Feb 21, 2023 at 4:09 PM Zhengping Jiang <jiangzp@google.com> wrote:
>
> Clear cmd_sync_work queue before clearing the mgmt cmd list to avoid
> racing conditions which cause use-after-free.
>
> When powering off the adapter, the mgmt cmd list will be cleared. If a
> work is queued in the cmd_sync_work queue at the same time, it will
> cause the risk of use-after-free, as the cmd pointer is not checked
> before use.
>
> Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> ---
>
> Changes in v1:
> - Clear cmd_sync_work queue before clearing the mgmt cmd list
>
>  net/bluetooth/hci_sync.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 117eedb6f709..6609434e3125 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4840,6 +4840,8 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>
>         auto_off = hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF);
>
> +       hci_cmd_sync_clear(hdev);
> +
>         if (!auto_off && hdev->dev_type == HCI_PRIMARY &&
>             !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
>             hci_dev_test_flag(hdev, HCI_MGMT))
> --
> 2.39.2.637.g21b0678d19-goog
>
