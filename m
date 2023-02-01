Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529DA686D3C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjBARmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBARmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:42:18 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654FE16ACA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 09:42:16 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id e18so3639875uax.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 09:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DzirROuW9olkK+Ab7CaPax/vy26m83TvhoASTzgpe7s=;
        b=MgduefyYKmVH0/uphx6SmYvMlqkdXAAesGCV3Esm2Na0ZtEPza9FAvPg41uHcdDMt8
         XFiCtee1BLy9bIK+7eKVrb8MMHOmXZ5JrdVfzEAahsp/CNNgSSvMtPaSl7HxkW3aWBr8
         1BO4IEjKMxJYGWi6/FNc4nAo7vqI5eZ5zih72sFyX0rlUgurMcK40SK6mxfTk9rF6aLt
         pJXkgbrlKXZ+dqQCrOX5rJMNO0jKqg5Opvwv0ntdS/17ijXxWM5R4liQrlupxyGgsvdW
         NtJIJborEXuvz6pIfVvb7tI32TCqXs2NLLLDva8UihCYmJ3Tcd7r/WRfzZmF1j4F4xmN
         IJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzirROuW9olkK+Ab7CaPax/vy26m83TvhoASTzgpe7s=;
        b=lsRkXkvdtK4gy8DrWH51BQ4y+7UixqkhJ5FFTKUeoZ2aRQnTvBtu9+MQJ5lC7YlnIP
         FIooe7gsYObT0oKSyzdbMzZlO6yC56D8FyRodpNL6FBNYna6g7+6X4m670Ks3N1inpFr
         vsLLQIMo4/CQnztCJz8JL6UzO48x/PARHM6lGVFKwdbLkqFqXZkaXROr2e39uxJfU3N/
         9MqP8RIGCCPO3eY6Ix4YMgmoCxe1quShUD3kLbkRFprtj51pVtIFthHQa5fz+lfBGY2d
         5vYslInOmEoidDfUT63muuYNMAUZ5m7o/U9GgfboFCQsQsPKBP/hpcVzLQrxRgZF/k9H
         dV0A==
X-Gm-Message-State: AO0yUKUU0NNprv21tuiAI/ZgGHVvnw3iP+HyqDVGNzwb1kJl7rdPeZJ7
        tuA5UEmCY9cKjVA5hpa6cLxxvRbVs4cRs6lOcIwwHSq4egKuzrqw
X-Google-Smtp-Source: AK7set9K8iWamQeVl4gcRrPOuazz8kMD8IjiJpud3M+NGaEqOWUJZVWLGASNYq+6DRVt5LzXsPpa+mReJvoXpxRewDo=
X-Received: by 2002:ab0:3008:0:b0:655:7634:8e78 with SMTP id
 f8-20020ab03008000000b0065576348e78mr482909ual.1.1675273335463; Wed, 01 Feb
 2023 09:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20230126215125.4069751-1-kbusch@meta.com> <20230126215125.4069751-12-kbusch@meta.com>
In-Reply-To: <20230126215125.4069751-12-kbusch@meta.com>
From:   "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
Date:   Wed, 1 Feb 2023 17:42:04 +0000
Message-ID: <CAJB8c05HgmDqMn9KwOi2P6+s-c8zt6-oiW6gOo==CDv6=HNahQ@mail.gmail.com>
Subject: Re: [PATCHv4 11/12] dmapool: link blocks across pages
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, hch@lst.de, tonyb@cybernetics.com,
        akpm@linux-foundation.org, kernel-team@meta.com,
        Keith Busch <kbusch@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 9:55 PM Keith Busch <kbusch@meta.com> wrote:
>
> From: Keith Busch <kbusch@kernel.org>
>
> The allocated dmapool pages are never freed for the lifetime of the
> pool. There is no need for the two level list+stack lookup for finding a
> free block since nothing is ever removed from the list. Just use a
> simple stack, reducing time complexity to constant.
>
> The implementation inserts the stack linking elements and the dma handle
> of the block within itself when freed. This means the smallest possible
> dmapool block is increased to at most 16 bytes to accomodate these
> fields, but there are no exisiting users requesting a dma pool smaller
> than that anyway.
>
> Removing the list has a significant change in performance. Using the
> kernel's micro-benchmarking self test:
>
> Before:
>
>   # modprobe dmapool_test
>   dmapool test: size:16   blocks:8192   time:57282
>   dmapool test: size:64   blocks:8192   time:172562
>   dmapool test: size:256  blocks:8192   time:789247
>   dmapool test: size:1024 blocks:2048   time:371823
>   dmapool test: size:4096 blocks:1024   time:362237
>
> After:
>
>   # modprobe dmapool_test
>   dmapool test: size:16   blocks:8192   time:24997
>   dmapool test: size:64   blocks:8192   time:26584
>   dmapool test: size:256  blocks:8192   time:33542
>   dmapool test: size:1024 blocks:2048   time:9022
>   dmapool test: size:4096 blocks:1024   time:6045
>
> The module test allocates quite a few blocks that may not accurately
> represent how these pools are used in real life. For a more marco level
> benchmark, running fio high-depth + high-batched on nvme, this patch
> shows submission and completion latency reduced by ~100usec each, 1%
> IOPs improvement, and perf record's time spent in dma_pool_alloc/free
> were reduced by half.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

So.

Somehow this commit has broken USB device mode for me with the
Chipidea IP on msm8916 and msm8939.

Bisecting down I find this is the inflection point

commit ced6d06a81fb69e2f625b0c4b272b687a3789faa (HEAD -> usb-test-delete)
Author: Keith Busch <kbusch@kernel.org>
Date:   Thu Jan 26 13:51:24 2023 -0800

Host side sees
[128418.779220] usb 5-1.3: New USB device found, idVendor=18d1,
idProduct=d00d, bcdDevice= 1.00
[128418.779225] usb 5-1.3: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[128418.779227] usb 5-1.3: Product: Android
[128418.779228] usb 5-1.3: Manufacturer: Google
[128418.779229] usb 5-1.3: SerialNumber: 1628e0d7
[128432.387235] usb 5-1.3: USB disconnect, device number 88
[128510.296291] usb 5-1.3: new full-speed USB device number 89 using xhci_hcd
[128525.812946] usb 5-1.3: device descriptor read/64, error -110
[128541.382920] usb 5-1.3: device descriptor read/64, error -110

The commit immediately prior is fine

commit c1e5fc194960aa3d3daa4f102a29e962f25a64d1
Author: Keith Busch <kbusch@kernel.org>
Date:   Thu Jan 26 13:51:23 2023 -0800

    dmapool: don't memset on free twice

[128750.414739] usb 5-1.3: New USB device found, idVendor=18d1,
idProduct=d00d, bcdDevice= 1.00
[128750.414745] usb 5-1.3: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[128750.414746] usb 5-1.3: Product: Android
[128750.414747] usb 5-1.3: Manufacturer: Google
[128750.414748] usb 5-1.3: SerialNumber: 1628e0d7
[128764.035758] usb 5-1.3: USB disconnect, device number 91
[128788.305767] usb 5-1.3: new full-speed USB device number 92 using xhci_hcd
[128788.406795] usb 5-1.3: not running at top speed; connect to a high speed hub
[128788.427793] usb 5-1.3: New USB device found, idVendor=0525,
idProduct=a4a2, bcdDevice= 6.02
[128788.427798] usb 5-1.3: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[128788.427799] usb 5-1.3: Product: RNDIS/Ethernet Gadget
[128788.427801] usb 5-1.3: Manufacturer: Linux
6.2.0-rc4-00517-gc1e5fc194960-dirty with ci_hdrc_msm
[128788.490939] cdc_ether 5-1.3:1.0 usb0: register 'cdc_ether' at
usb-0000:31:00.3-1.3, CDC Ethernet Device, 36:0e:12:58:48:ec

---
bod
