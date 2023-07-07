Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8B174BA0D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 01:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjGGX1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 19:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGGX1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 19:27:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2B12107
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 16:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E54A261AAF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 23:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCE2C433C7;
        Fri,  7 Jul 2023 23:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688772458;
        bh=P+uTzSoEqJJWCevlsdh+M1GqE95HMg/uVvhx5B1sX1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g7qA+fyPMtwHwYkAqhITQUei9SCkfMhs7WRXaXAJGM1VslLzlR+unsnZj0WbYsPXb
         6xAE4bLv9l2Lq/hVKRRUwpN2bU9q7TtlmjiPfkTi3upYlPY5VQ3x1g8m3TrUgdcnT9
         sUdPou1NXL1PYYNLgF0XbVxv8YYcSis/9GkDPcoIjU93vlM++GwTOzszv9KyUTsSTu
         mAXHxOaP5JLj9Ku0t+qiW55ca/WhLsQLlMJq2K2AjTF0O2Bt+MTZPYD15YEGDfh71y
         10qneoudIs8cClwUT79qcLm70hH4hC+lXLxMEemyXADmZ6Rhwy0yDqq+07u1lEGqPL
         XDwKFAgsHtsJg==
Date:   Fri, 7 Jul 2023 16:27:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Forbes <jforbes@fedoraproject.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move rmnet out of NET_VENDOR_QUALCOMM dependency
Message-ID: <20230707162737.0a411b18@kernel.org>
In-Reply-To: <CAFxkdApnEo8RPOQ3zVjAZBeTtH2UbaT2798gQ5w0SA5e-dtZng@mail.gmail.com>
References: <20230706145154.2517870-1-jforbes@fedoraproject.org>
        <20230706084433.5fa44d4c@kernel.org>
        <CAFbkSA0wW-tQ_b_GF3z2JqtO4hc0c+1gcbcyTcgjYbQBsEYLyA@mail.gmail.com>
        <20230707151206.137d3a94@kernel.org>
        <CAFxkdApnEo8RPOQ3zVjAZBeTtH2UbaT2798gQ5w0SA5e-dtZng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 17:19:12 -0600 Justin Forbes wrote:
> they add an entry for it, and don't realize that the entry is ignored

Maybe that someone should not be "adding an entry" to a file which 
has this at the top:

#
# Automatically generated file; DO NOT EDIT.

?

> VENDOR_QUALCOMM is not enabled.  Either all devices capable of using
> rmnet should be hidden behind VENDOR_QUALCOMM or rmnet should not be.

I agree that Qualcomm drivers are an atrocious mess.
They should live neatly in the wwan section. But it's Qualcomm,
they don't care. Let's not have it sprawl even more.
