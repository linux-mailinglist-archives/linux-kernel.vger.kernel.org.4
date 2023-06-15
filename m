Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DA4731460
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244166AbjFOJrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbjFOJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:47:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454261A2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:47:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b517ee9157so3028455ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1686822459; x=1689414459;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcIbsuTuras7nhZRKwXQYUq8Gmb7hiznRWwdCPO8xpM=;
        b=aQGO6ueCJziuDO+nAGnGz5QTl5OIKIrHs2i/hdOQKmAgBl4NTbEF1FRxIZGr6oiKVr
         /kynnbR43iXhit/NSlrXDmfTvgDE0HhrlyCWduduh9BjVekMKhHhBRlq8lT/ipShEooi
         cMHo6Yn0pimsYW+JmQcRZyz8zv6gw8saL1C+qbe5FXq91uU8D4P4d7oQB+CKeFY6Cw8F
         0cyghIRKVXG5pm5m8XSsNklnZv0BqLC1QRHKZQhHwt6IwB36xAaTm2sErgNDdYsyF5EO
         xEzPHJJSm82TCnY6gEwxT21zSgLm07cT8e6ZxUcKMyag9W9EnGAr5bpmO0T0QlL8QMcd
         AMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686822459; x=1689414459;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcIbsuTuras7nhZRKwXQYUq8Gmb7hiznRWwdCPO8xpM=;
        b=lua+JAO+j00l7vbrDUDquVlbp3OIqxetf7JfMhQ4MilLj7oNt98XnukGaOts90NpL4
         I+dL54g159EV85AjFS3kAWyE87OpyQ0JrfXO0CL3qvZPh8K40uqwv+WPky4XEjDs31TM
         ttc/X+NDmHws+/DuyDaPaDf87PgI5H8PyIWQrp2SUH7wazqPSnrkHAS9S2M4WLq301pu
         ogm3Xr9uIXxoTXTEp1Bs6sBRiy7seoc6QXbgZdfE047hUdf1tHoH6Feb9dBN5Y7xDMG4
         Ny27EyVt6vupTG2PEAfjUKgiSS/IxkbgZzqnRkfXzh2ew57uwJcq7AgdqWXDqF9DdnQd
         dh6A==
X-Gm-Message-State: AC+VfDwxrGg/Vlbu1QG7khehoMcjAkgXRaZzk4bpzoRB+EHK5tK7sGr4
        bSGbX8CNZgJZpXlmiq0m21FgAQ==
X-Google-Smtp-Source: ACHHUZ4DB1lofP+kyQ79jZotePluoFWtcHF3WEHWh7MQjOnnqgczFkuipTQ03MximRBmBW9a4rI9mg==
X-Received: by 2002:a17:903:244e:b0:1b3:c7c7:74ae with SMTP id l14-20020a170903244e00b001b3c7c774aemr12312783pls.45.1686822458748;
        Thu, 15 Jun 2023 02:47:38 -0700 (PDT)
Received: from hsinchu15 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id w22-20020a170902d71600b001a64851087bsm4800996ply.272.2023.06.15.02.47.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Jun 2023 02:47:38 -0700 (PDT)
Date:   Thu, 15 Jun 2023 17:47:33 +0800
From:   Nylon Chen <nylon.chen@sifive.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        jszhang@kernel.org, ajones@ventanamicro.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [PATCH v2] RISC-V: Support 32_PCREL relocation type in kernel
 module
Message-ID: <20230615094732.GA8710@hsinchu15>
References: <20230615072302.25638-1-nylon.chen@sifive.com>
 <20230615-unvisited-deceit-9beab8ce987a@wendy>
 <CAHh=Yk_=oZJ6eY3jJzLavub5rGsvY=MKv4tGXeiqkz+rgJHwDQ@mail.gmail.com>
 <20230615-luxurious-rewire-84ff9d639fea@wendy>
 <20230615084310.GA780@hsinchu15>
 <mvmo7lh2ip6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvmo7lh2ip6.fsf@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:11:49AM +0200, Andreas Schwab wrote:
> On Jun 15 2023, Nylon Chen wrote:
>
Hi Andreas,
> > Because LLVM currently has it enabled by default(https://reviews.llvm.org/D145164), it will generate this
> > relocation type.
> >
> >>From what I know, GCC will also enable it in the future.
> 
> That's why the kernel explicitly disables it.
Ok, thanks for your feedback, after I cross-tested, there is indeed no relevant relocation type generated.

If this error no longer occurs.

I am open to the idea of adding this patch to the upstream and would like to hear your thoughts on whether it is still necessary. 
> 
> -- 
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."
