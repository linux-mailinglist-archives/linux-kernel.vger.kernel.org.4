Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CED608FB2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 23:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJVVPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 17:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJVVO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 17:14:56 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C0D2BB15
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 14:14:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k9so5296797pll.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FvC1lDuEXWCYXb2hvcgpYlisVDpfK5faSIaWNOzeHs=;
        b=jlu1d0/979sEdmVA9E65clPF3vKSUXLVMq4DubRcFyekFo2JoLF0YlZ1TDK+QJ0fky
         IVppFZGJBgrTs6hrAK9xyg2vMB430B1x76T+UHDsvxy9JuF5vSFZNTpWugnc9fNWheQa
         FdEupfGAEWcVxdaw9RdXO1X72DpKTdc5qaBv7wNtjYYcW6/34+bd8qXeyGEyDmW81LKu
         QQM3w77dP2ouOSefV0yVCubstp5zrmR1ijLYa1ClUzCE5mvDNdzOkegUSRPDFwdQ8ioC
         ldmep5tia0oIWmbZI6au0QkSBRhsFPmYRzP97JZ+gHfPLFMoMyxpiXtfPq0NT1YRNVrQ
         N5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FvC1lDuEXWCYXb2hvcgpYlisVDpfK5faSIaWNOzeHs=;
        b=iBswex4mLnn+SnwdJt5MyeGY/5OdyQTxZyiEw9IbumfsMkXqW7DwwMlg4xMrV3i/6/
         5Woo2FqJ37bpEr5POKD+Kp+7+iNSXDUx4ePVfcW8XLYGmBGDsjYfIe0+cKfHQh/7+1J6
         /jXFn4FRCMmGF0xUjS6pcvijqvAoxyhcji9rT+0DeC2DKbMc5sDeROhujlvtOFFdqidm
         9y2/fYcaAcKqzLW5hzN7sJLiSAGomZCGwOJR77Lgpss1qLOlqo3JAT3woll9ybbLUm9P
         ogIeeXVoi0otpoY15ulzf1fsNNJdp86d5hmtW1D3CB7meb2bY2R1V/nFIqcZvjM0BWES
         scBw==
X-Gm-Message-State: ACrzQf2EgOzgaQcdRsKGSblInk6zgsrLkkwE8WYysPLce7P8sSIbu5BE
        dy9e8qRHSDQUREC745YuwOSAESDXrTeptknV
X-Google-Smtp-Source: AMsMyM7Qu+Y+AtNozdZGfdN2QL/ZRk1f0kTozESOa9h9ASGH+K7+VptQo3OgTLUNf28FrWRcUbZLtg==
X-Received: by 2002:a17:902:eb83:b0:185:46b7:7de3 with SMTP id q3-20020a170902eb8300b0018546b77de3mr25764664plg.19.1666473287610;
        Sat, 22 Oct 2022 14:14:47 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q15-20020a65684f000000b0044ba7b39c2asm15129489pgt.60.2022.10.22.14.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 14:14:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, hch@lst.de, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, yi.zhang@huawei.com,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
In-Reply-To: <20221022021615.2756171-1-yukuai1@huaweicloud.com>
References: <20221022021615.2756171-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] block: fix memory leak for elevator on add_disk failure
Message-Id: <166647328666.27452.18046414061378704307.b4-ty@kernel.dk>
Date:   Sat, 22 Oct 2022 15:14:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2022 10:16:15 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The default elevator is allocated in the beginning of device_add_disk(),
> however, it's not freed in the following error path.
> 
> 

Applied, thanks!

[1/1] block: fix memory leak for elevator on add_disk failure
      commit: 02341a08c9dec5a88527981b0bdf0fb6f7499cbf

Best regards,
-- 
Jens Axboe


