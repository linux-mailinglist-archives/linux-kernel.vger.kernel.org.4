Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62C96E6938
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjDRQTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjDRQTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:19:21 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDFA3C38
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:19:09 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6a5dd070aa1so342404a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681834749; x=1684426749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsNkAdqM5aD2ANf2aq6x/sAPaPOROg0smhWtJ73OXYs=;
        b=Sqlv8ClHnfQZPFsrmEcOMumnOCOHXaU1q8XZnnR+cVd7QPERQnk9za9OeKrPnFiqT0
         nZ0HdvV+fp/a7kxXTWIBap8aCNDeekzScT4vK8cGYrvM6LaSTmhJbIg86eQYdD0tlYbV
         dPJ5Rw+waxLIIrl0ul3oICIfTuZK7F0JHCn5DRJVSFBTvOQFAmGsAE3qAcNB6bbAKfyS
         GpPSZUcBWLq6qVsSYMRqz3Qaapl8rYL3E3fuUgBoXtCUoGbr7N3fDeO3Zivgv+ixrZYc
         jPB+pyEnW0kCNZsMD/ruhUnlW/uXxflZm1BMupMoctoIgTaT6aI/qYxqK3TZaQ9Y1UqV
         w87g==
X-Gm-Message-State: AAQBX9epCA839Xx9Pw+dPMZCyDs2RJ1bO/zqa2GJV79OrNtiLwKHxVRk
        EtipkkQdWzORjPTEpfuAKw==
X-Google-Smtp-Source: AKy350ZQ9hDoEoaPayGHqbuZMQ4z6qGooQGxhMDUvpCpNxIDb/xxzku5Cq8d+PW4k0L5LRVI1Sdq6A==
X-Received: by 2002:a9d:4b0f:0:b0:6a4:319a:6d7f with SMTP id q15-20020a9d4b0f000000b006a4319a6d7fmr1558335otf.9.1681834749102;
        Tue, 18 Apr 2023 09:19:09 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n1-20020a9d7401000000b006a1793e3571sm5593153otk.61.2023.04.18.09.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:19:08 -0700 (PDT)
Received: (nullmailer pid 1777444 invoked by uid 1000);
        Tue, 18 Apr 2023 16:19:07 -0000
Date:   Tue, 18 Apr 2023 11:19:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mvebu-mbus: Remove open coded "ranges" parsing
Message-ID: <20230418161907.GA1764573-robh@kernel.org>
References: <20230216181204.2895676-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216181204.2895676-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 12:12:04PM -0600, Rob Herring wrote:
> "ranges" is a standard property, and we have common helper functions for
> parsing it, so let's use them.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Compile tested only!
> ---
>  drivers/bus/mvebu-mbus.c | 58 ++++++----------------------------------
>  1 file changed, 8 insertions(+), 50 deletions(-)

As this hasn't been applied elsewhere, applied to DT tree.

Rob
