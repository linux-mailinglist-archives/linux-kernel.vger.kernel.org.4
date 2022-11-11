Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0E1625374
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiKKGPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiKKGPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:15:46 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D0613FB8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:15:46 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id b62so3694238pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3askcQWU5u7LnQuB7pdoKcm0FfvzSf9Zwubk2DsWzGE=;
        b=L1oBnin8Hpo+fK10aQNq4eUkZbDFTu59oUwCi+IoRQfum8uX7ny0hpNLGFiZnZrCc6
         b2TxrxrsaQ/vk4T7zYLJEsEIW7kpHnmiBGbvgLgo+fiuyN3lmpEdy2BY5g7UBWwBkyeQ
         F6hjncS8YIGSDaG6cKlq1qVZHFTtlXz02EOqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3askcQWU5u7LnQuB7pdoKcm0FfvzSf9Zwubk2DsWzGE=;
        b=X0JSzfVKuN/LJZONJF99pO1whs8rYxPF6oapKhWyUUA/jAv53cBSZ4hk/j8pf88cPR
         jhtOA4aa8lEF7PSie7dHjfvTarCD+xjdnRtJSvE9NjrWWjXgS+DgoMQpCQqQdxrQsY+U
         UzoGFrGflPtVg/H7o4//h3gvP/N9hR5bYrpqmSVwVDicl4x+l/YTrMLEtG4nsWOkDs7F
         mAVF50r8JbCkibyzg9Bumy26iKvYrvI3chxyUDB26YIzyTCEkhOuzcwOWgfHJ3MX3ZpK
         WnJajNMxCaAEsXNjnyN/kQ9eTgNdzv3iQ63V2q7pSYFrENog/OVWD0J+DZvd6Kv2Ri3y
         m78w==
X-Gm-Message-State: ANoB5pkmA7vfEitNc+ei525NpDu42vcr8bgfyAZSH84dAoY2QA/6OPv9
        HOwYCwr7pJresqtnzmkAP30syg==
X-Google-Smtp-Source: AA0mqf6WEaBmALGXMxgkBBL09bKlayGHwQr4T1+exECrVOPEE5WFAGY9fLj9KxzTz7lJim+9TSVTEA==
X-Received: by 2002:a63:1c09:0:b0:46b:2bd4:f298 with SMTP id c9-20020a631c09000000b0046b2bd4f298mr445240pgc.135.1668147345532;
        Thu, 10 Nov 2022 22:15:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ja13-20020a170902efcd00b0017f7c4e260fsm760315plb.150.2022.11.10.22.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 22:15:44 -0800 (PST)
Date:   Thu, 10 Nov 2022 22:15:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, dalias@libc.org,
        ebiederm@xmission.com, sam@gentoo.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3] fs/binfmt_elf: Fix memsz > filesz handling
Message-ID: <202211102214.D764FAE21@keescook>
References: <20221108110715.227062-1-pedro.falcato@gmail.com>
 <202211101934.22CACD615@keescook>
 <CAKbZUD2r=zK91J4c6pyHQhDuqqMzmrx+BBgFF4Cso2jK+jjhHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKbZUD2r=zK91J4c6pyHQhDuqqMzmrx+BBgFF4Cso2jK+jjhHA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 03:59:08AM +0000, Pedro Falcato wrote:
> We could of course also just sort the program headers at load time,
> but I assume that's unwanted overhead for most well behaved ELF
> program headers :)

Large refactoring of the ELF loader needs proper unit testing, and we're
still a bit away from that existing. In the meantime, we'll need to make
very very small changes to fix bugs. I've sent a minimal change which I
think should fix the problem (now at v2 since right after sending it I
realized I was trading one accidentally correct state for another in the
v1):
https://lore.kernel.org/linux-hardening/20221111061315.gonna.703-kees@kernel.org/

-- 
Kees Cook
