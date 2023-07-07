Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E5674B965
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjGGWMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjGGWMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:12:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB651FEB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B9DD61AA5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 22:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FC6C433C8;
        Fri,  7 Jul 2023 22:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688767927;
        bh=3GVQ87GFe/N128MNUePXr84Z9uHM4Shi5hKdcsz++pk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UCsdXbwFZFiiJemnLWCQWnzrj2oZ3dKL/+o7acuwgqUaBAyKgov0z53Ajpfg1yYvw
         62GtDgzdZwQfVJbN1vQkblhb1t3WJcLicm1xUtgwab6zJlV8EAodg0FLIA13tFHzhZ
         sR5pjSjo+5gdgzrJOa+D1rOqt7PRhjn/tbIgYqROLl8lazsX6Vewi4a0ACenVtd+1h
         few1IE8yrG9wAepF6R0qdlG+C9/7B51P5v3eKX/WQyR7VD+r2lQ/0rzedIdymWzMNn
         FhXhYR9RpYck/Vr+tKjYTiz2HIDTRsxZnPVlqM/fMhHh1304cbzmBqld+L8yqKMrP+
         vmlHyal6159IA==
Date:   Fri, 7 Jul 2023 15:12:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Forbes <jforbes@fedoraproject.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmforbes@linuxtx.org
Subject: Re: [PATCH] Move rmnet out of NET_VENDOR_QUALCOMM dependency
Message-ID: <20230707151206.137d3a94@kernel.org>
In-Reply-To: <CAFbkSA0wW-tQ_b_GF3z2JqtO4hc0c+1gcbcyTcgjYbQBsEYLyA@mail.gmail.com>
References: <20230706145154.2517870-1-jforbes@fedoraproject.org>
        <20230706084433.5fa44d4c@kernel.org>
        <CAFbkSA0wW-tQ_b_GF3z2JqtO4hc0c+1gcbcyTcgjYbQBsEYLyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 11:50:16 -0500 Justin Forbes wrote:
> > On Thu,  6 Jul 2023 09:51:52 -0500 Justin M. Forbes wrote:  
> > > The rmnet driver is useful for chipsets that are not hidden behind
> > > NET_VENDOR_QUALCOMM.  Move sourcing the rmnet Kconfig outside of the if
> > > NET_VENDOR_QUALCOMM as there is no dependency here.
> > >
> > > Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>  
> >
> > Examples of the chipsets you're talking about would be great to have in
> > the commit message.  
> 
> The user in the Fedora bug was using mhi_net with qmi_wwan.

Hm, if anything mhi_net should not be sitting directly in drivers/net/

I don't think this is a change in the right direction, just enable
VENDOR_QUALCOMM? Or am I missing something?
