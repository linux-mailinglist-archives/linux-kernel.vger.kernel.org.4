Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1F3626E70
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 09:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiKMIGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 03:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMIGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 03:06:05 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D5C1006E;
        Sun, 13 Nov 2022 00:06:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q71so7786278pgq.8;
        Sun, 13 Nov 2022 00:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zM9r/sE2arMe1ziHsoXHyeiwa3rJRhwbTpoZQenkP0=;
        b=eZ8puorRy851lsvelSzqMSeeLyZ4dV/kj02RSvfxz1CQuX7fx1TxcZtxfNmbGjMJGF
         +ZI2oYdWVxBDMCpXj0YQrvConklIYJ02MeF8RCBnxAS/3CF2C86NQNdmSNg8FpbuIpy2
         QKqg4xH9KvokMAZKtLksRBhc7koYM57D36C3vQFkHeYkVvxR+zriFm5Aw/SnoFFklqPV
         2OPFS4DiqmQfxaeB/SEQpfM2Lw7erJQmU+ZqbnyJ1mWTg509s68ce3avOo5e9kzojrmQ
         rN8MzWbATBEdqg0YAoC5NPb6ixEwkGgSxANFHOhHD6n56sS+QehH7/sDMu/Vgd9VVG6f
         UNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zM9r/sE2arMe1ziHsoXHyeiwa3rJRhwbTpoZQenkP0=;
        b=NChT5FCNlPH0XW/UQ0UiylJ+VYF1VnRI5oeqelJ0ZhZKv8lhu/UlI3m53jVf9pSFQk
         HcMT3c8J/CVYutXY8AZOL/BFGzPHZRanB9zsH54M3OjVXp1iwGbJeExL6zgO0I2oNcka
         aeyGz1yFlLqQ9e7SvtAygVygrvJJBB/Fa+o0yZuO1Nhr97XkKCZ1lZGEr37JxZ5VbuOi
         gIv2N/u97gh+yUzgo3pFlKY7NESpgVGT+KrbIGRg60rSy192aJf/XH79CEPCFgi1J5Zy
         //Ygst8R+TvFqGNKYjKJWmsVCTxZ1wluAYc1nZSZW6FJsSsgqX1fjX2EVjKW6IdGpzTQ
         s17A==
X-Gm-Message-State: ANoB5plngP02X9in9q8sCjpqFLyacaqSUM40uoF/WMa5JTR3aFxwmsW8
        xKgX21cBNfOY4LAL23+j3No=
X-Google-Smtp-Source: AA0mqf62uGra28MbBIJtSsfR0SDiKM8zckf3fK3DM9gnnUl+ck/7KxqUed0gBGcKx0jO/XbDtT/KEQ==
X-Received: by 2002:a05:6a00:1592:b0:56b:e2db:5b88 with SMTP id u18-20020a056a00159200b0056be2db5b88mr9358474pfk.27.1668326764475;
        Sun, 13 Nov 2022 00:06:04 -0800 (PST)
Received: from ubuntu ([211.193.26.134])
        by smtp.gmail.com with ESMTPSA id f193-20020a6238ca000000b0056d2797bf05sm4279947pfa.217.2022.11.13.00.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 00:06:04 -0800 (PST)
Date:   Sun, 13 Nov 2022 00:05:58 -0800
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, imv4bel@gmail.com
Subject: Re: [PATCH v2] char: xillybus: Prevent use-after-free due to race
 condition
Message-ID: <20221113080558.GA5854@ubuntu>
References: <20221030094209.65916-1-eli.billauer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030094209.65916-1-eli.billauer@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear,

Sorry for the late review.

This patch cannot prevent the UAF scenario I presented:
```
                cpu0                                                cpu1
       1. xillyusb_open()
          mutex_lock(&kref_mutex);    // unaffected lock
          xillybus_find_inode()
          mutex_lock(&unit_mutex);
          unit = iter;
          mutex_unlock(&unit_mutex);
                                                             2. xillyusb_disconnect()
                                                                xillybus_cleanup_chrdev()
                                                                mutex_lock(&unit_mutex);
                                                                kfree(unit);
                                                                mutex_unlock(&unit_mutex);
       3. *private_data = unit->private_data;   // UAF

```

This is a UAF for 'unit', not a UAF for 'xdev'.
So, the added 'kref_mutex' has no effect.


Regards,
Hyunwoo Kim
