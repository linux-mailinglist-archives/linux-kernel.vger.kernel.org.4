Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA17487EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjGEP0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjGEP0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:26:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF0A171C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:26:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso3396290b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1688570767; x=1691162767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xa8l5W64uJlvGeV+OrN8NQyDk5eo1H48/yo/RAL/jPM=;
        b=wtRhMYODWW5ptCVw3fLk0aA1jDVnCN2D3TXW/GyxF76M3TKqbLIRLr1JkLsrT8nubJ
         Qz50poPgRue6koZQT0gYGV8idVBIvAAVJyZfI0p4YthpOpMmrFny9AX5rhScFxorqj0j
         MJepXmZ5UimQ3SzY2ZyLDVP5dIUXoOT9oG2UDHI7XMyBBjyIl/9AkzkOEOuKhk2IH4Ga
         zJCv6Tx20j8DRKjlycZnBru76vw+Qtq92JdWhEGKO2tDxjHYRwVMi6HV4F3E+M6Pu1m2
         DybnTJpN6t9Mfo/Oq2hX+srsXDpcJZBAWNHzRZ/TxtF7NGiZmz0HJE/fDLe+4SlFEgRh
         KyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688570767; x=1691162767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xa8l5W64uJlvGeV+OrN8NQyDk5eo1H48/yo/RAL/jPM=;
        b=ILrLzlX9oXKe2u4OOlI5+f7b4YI7K39cj+8qzJapShLNUS9Ny4MS1H4hWvQtOtrHBg
         m8PwHybULW3iWsVvUN8G8y3yJZmu1PKTGBeSyvnhoqzc9jNdT1VJ++t2PsZO9W0rIu2g
         I84Hg14FG/cSDGlObpsc4y5Xdo6JN/l34boCQPRpdhARkQZbmwfZyZOl+hDiKq5BSJ9E
         DWYBbru067qNZx3noKDUsxnQFoqoeuAINLZaNnaFUrhqZ7wu6EkmhfvPhS6U+Fxojomv
         5tJUwzp9TEdZmeqNuLNh/Mn+Ajs51A3eLlivc6Ml9kO5U9jsTs1CpyyvRLXLzBODD7ec
         VW/Q==
X-Gm-Message-State: ABy/qLZsQY3iqhGTtnMtgsgNRvtVr1CIKCVLM2cKo/CXQwT9j668QeO9
        oBeTxfE5I3l++RTzhzW39eDf2A==
X-Google-Smtp-Source: APBJJlHe03DAPIWSU5hFp5ndbVtx5g2LL1bHur1wfB7oOHBaFZExIoTqYGQzhvHF4K8+cVs6X5sMAQ==
X-Received: by 2002:a62:7b42:0:b0:67e:bf65:ae68 with SMTP id w63-20020a627b42000000b0067ebf65ae68mr12948969pfc.3.1688570767138;
        Wed, 05 Jul 2023 08:26:07 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id q23-20020a62ae17000000b006758ae3952bsm15692092pff.122.2023.07.05.08.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:26:06 -0700 (PDT)
Date:   Wed, 5 Jul 2023 08:26:04 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, sergey.senozhatsky@gmail.com,
        pmladek@suse.com, tj@kernel.org,
        Dave Jones <davej@codemonkey.org.uk>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <20230705082604.7b104a48@hermes.local>
In-Reply-To: <ZKU1Sy7dk8yESm4d@gmail.com>
References: <20230703154155.3460313-1-leitao@debian.org>
        <20230703113410.6352411d@hermes.local>
        <ZKQ3o6byAaJfxHK+@gmail.com>
        <20230704085800.38f05b56@hermes.local>
        <ZKU1Sy7dk8yESm4d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 02:18:03 -0700
Breno Leitao <leitao@debian.org> wrote:

> The uname is useful if the receiver side is looking (grepping) for
> specific messages (warnings, oops, etc) affecting specific kernel
> versions. If the uname is not available, the receiver needs to read boot
> message and keep a map for source IP to kernel version. This is far from
> ideal at a hyperscale level.

At hyperscale you need a real collector (not just netcat) that can consult
the VM database to based on IP and record the meta data there.  If you allow
random updates and versions, things get out of control real fast and this
won't really help much
