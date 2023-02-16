Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A81269897D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBPAvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBPAvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:51:50 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC512E0FF;
        Wed, 15 Feb 2023 16:51:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x40so807800lfu.12;
        Wed, 15 Feb 2023 16:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CE4xiLmA9VQyI91JLYE61lSZLDddIMxME/1xb4rDChM=;
        b=FFLdjQhRgM6nTbQB//R6Ov520KvRlsMBttV4XYizVX39hkJ17stscJ2kC/2F2SsrCq
         zzq01UwVC+BCJMnRmPiD03D5wBwCb9Bp63al7ELpY7QH9RQGTii1g8BQqZW/Lef5ONzy
         cXb4Q+LhJcxSCgw7uqtQ3qcW9cr0H1CXxR/xnYulcpcdtUi1a0gUYbO5xhkapjocfD3N
         pHMPw6tua4wDOimnbnizgpTuLSb3lU9PMlgjWvPspCi5NcyFw7ilbD8F1apRwhPaeR18
         QsNtyYsZlwFP5S2G8irueAl/C/1zyZlwQmGKbuJ5NoR+7lr64oL36LY8xUStwa6D6a3G
         M97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE4xiLmA9VQyI91JLYE61lSZLDddIMxME/1xb4rDChM=;
        b=A+HRGxYHW78YPGV8PGUUhYQCYIUwtjJdGf9rPYZxjqyVGkbkBcpfOzfCtpBfSVQBbX
         4313KWXdzTn6uQrzwsvgD8N6FfsfrRmEHt9+VVBRIb2hyjNiyLog1nFjb1jOuDJKrADD
         qnqAZsydYkaddXQ7L3rmWuwobVvcvuPChsCbmPD/WQyPRQyDR4KOctEBPBj4xHrJ0xNC
         SYpYgfT2i+VvaFlLDHvN4vjqDnhqx42U+hvVWY8kHIfl7Al+mgNk0djsgi+GS+yQh5Au
         BNQoNvCZzsxaLvIZFokLMDL2rV1wF9G00GZbBCN/paGN68o0GGiX5Y0xTRVJYpCirdx7
         KrQQ==
X-Gm-Message-State: AO0yUKWJD3zLL9eQroR9Nr/vFDwSHDWcqUPZQbvMwMrDlooKwSBUELyP
        NyyoViro2/SZeR+2L9pyeoZDYCqJ2g+wuwYJFg==
X-Google-Smtp-Source: AK7set8xhRSu9owX2yBWOpqwdcAalnQf6+Nf6OvAqzeeso7SajB/K2u/G+Hz53aTuLqRNuI6D5TYWnUmksvLC5x4tl0=
X-Received: by 2002:a05:6512:4c6:b0:4d5:ca32:6ae0 with SMTP id
 w6-20020a05651204c600b004d5ca326ae0mr1100720lfq.0.1676508705519; Wed, 15 Feb
 2023 16:51:45 -0800 (PST)
MIME-Version: 1.0
References: <20230215123750.15785-1-powen.kao@mediatek.com>
In-Reply-To: <20230215123750.15785-1-powen.kao@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Thu, 16 Feb 2023 08:51:33 +0800
Message-ID: <CAGaU9a83SfYsShOOTPTQCCHCSt=4E0WuVg6K0OipAyUq73pbrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi: ufs: core: Fix mcq tag calcualtion
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        chun-hung.wu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com,
        mason.zhang@mediatek.com, quic_asutoshd@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 8:38 PM Po-Wen Kao <powen.kao@mediatek.com> wrote:
>
> Transfer command descriptor is allocated in ufshcd_memory_alloc()
> and referenced by transfer request descriptor with stride size
> sizeof_utp_transfer_cmd_desc()
> instead of
> sizeof(struct utp_transfer_cmd_desc).
>
> Consequently, computing tag by address offset should also refer to the
> same stride.
>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
