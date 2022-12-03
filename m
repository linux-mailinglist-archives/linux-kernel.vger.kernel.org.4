Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354786417C8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 17:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiLCQ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 11:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiLCQ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 11:27:56 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1CFA454
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 08:27:54 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cm20so7583630pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 08:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFhsulPsPHvOyONkpTyQ+xbocqKNoUqhz2MWHZ1fQoM=;
        b=HCV4bo6pyoFwPnLnxUrE4+NQmiEIvSzc38MWSU1F/O+3k3vreVhIfDjfXwbMfOg0Qj
         +IPcbiQfIU7NWl+vN0iiSASnjXtNhDGBZNpx7jZV9d20OqP+Lmk5bL+Bu5xrRbW91Yzr
         SMI045jHxPND23hM6R8N5j1DX9YOTAUxz/WcMCewEcsafxten0ifedj6ZTD/CCz09TK+
         DefvvjJCUnmaCM5igfODJrKqXssU0SO7FfrSxPWIQV2t7uyEm8iY8z3Jd4X42Tx3Hod6
         kMTGsi1bSTJOcKmFmxkyRkNdkAUIfwMCb0Dhh/fw0UjqnP+x0IeJzheSb9Y0lY+Znyj9
         9MlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFhsulPsPHvOyONkpTyQ+xbocqKNoUqhz2MWHZ1fQoM=;
        b=OIVH94yx57iq1yOLerkgWv0VTtXBZpaZwdau40tglpmoAGdoBhN3xdyze0S0nYka4i
         U7P5A0TAj3VmxihtSK6TWAGva7+OAuy9HPFmJuQAX6X2ytTA3ycrUynr7g11Wm2aF+Uo
         eytIyBAmD4eFaxeJbwzFvgh9mXtR9r5XrsW+4goQxTLBytClZ0m41nSkSYcRNR54GG/v
         8fvDuTptrtPoZxMU3hURBxutUfs30MnBNhAKlot1ZKttW0Vcp1iEpmCg2a5309mXAk6G
         LMBJfVNsm2m5coUd754al3D1f3YOqv2gu78O48izwhE0jopVLTWOX5XTBkKonrOHiK+H
         uu5g==
X-Gm-Message-State: ANoB5plcurB+sIZw7InA+cYygr594mqDlG1kkgAP/4PqG5ZInzJ0UWrz
        SR0E9ujqZL5MCT9vvdPvA0vucrUv7yuYoFW6XV8=
X-Google-Smtp-Source: AA0mqf4l9Gq/NyriF9XNkJYHsltSulsw3feL9iCauzAUehTiMaovPc+hql9CG/b5bLj8iK9/iKEEAg==
X-Received: by 2002:a17:90a:440b:b0:219:886b:9155 with SMTP id s11-20020a17090a440b00b00219886b9155mr9592082pjg.167.1670084873536;
        Sat, 03 Dec 2022 08:27:53 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b0018980f14ecfsm7658119plx.115.2022.12.03.08.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 08:27:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221203140747.1942969-1-gregkh@linuxfoundation.org>
References: <20221203140747.1942969-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] block: remove devnode callback from struct
 block_device_operations
Message-Id: <167008487227.998221.5510218779438847268.b4-ty@kernel.dk>
Date:   Sat, 03 Dec 2022 09:27:52 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 03 Dec 2022 15:07:47 +0100, Greg Kroah-Hartman wrote:
> With the removal of the pktcdvd driver, there are no in-kernel users of
> the devnode callback in struct block_device_operations, so it can be
> safely removed.  If it is needed for new block drivers in the future, it
> can be brought back.
> 
> 

Applied, thanks!

[1/1] block: remove devnode callback from struct block_device_operations
      commit: 85d6ce58e493ac8b7122e2fbe3f41b94d6ebdc11

Best regards,
-- 
Jens Axboe


