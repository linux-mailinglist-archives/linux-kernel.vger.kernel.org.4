Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84766A608F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjB1Uou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjB1Uol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:44:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B3272BF;
        Tue, 28 Feb 2023 12:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yE+EIds/wjormfXL1oIAYTyhaZEiJTiletVx3HkCpnE=; b=f0iRb3/eAKMHpXwMz+AYdp88HL
        aGAvYvu/cq2dZQcWiHxCNq9TlPGCrxG7uRLtfM9FTbZ9b3lKi5bAmyPWUGk9vVsb4iNqWSASKUFGO
        UeXFUCXBzWn43HBjMtGPsZlHj/8i3Q6Dm+pekeNYjwWoUUZ5uK41ETZkbOHyhigi0ptzNRslFGSoG
        4PF3m6pol12cOd3B5OlzkXEHOwhZ1dNLKMulXCCrpensk9fyOLHTPgRUIoaEgp+E/vGgZbUlspQUD
        nkzlBxBHh/baTwh5T3wM8W7JyvrKSAqIf0RGdcByaGnBhjpYbAO4HBUqgyFOAWnw3reXh2awMlqpX
        r+Ate8Cg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX6py-00EEEO-7d; Tue, 28 Feb 2023 20:44:38 +0000
Date:   Tue, 28 Feb 2023 12:44:38 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     jim.cromie@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/2] dyndbg: use the module notifier callbacks
Message-ID: <Y/5ntkYoKHvfU9S8@bombadil.infradead.org>
References: <cover.1677612539.git.jbaron@akamai.com>
 <a775dcc14a10d0b3df34e087ee29ddb1d62fb517.1677612539.git.jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a775dcc14a10d0b3df34e087ee29ddb1d62fb517.1677612539.git.jbaron@akamai.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 02:35:02PM -0500, Jason Baron wrote:
> As part of Jim Cromie's new dynamic debug classmap feature, the new code
> tries to toggle a jump label from dynamic_debug_setup(). However,
> dynamic_debug_setup() is called before the 'module_notify_list' notifier
> chain is invoked. And jump labels are initialized via the module notifier
> chain. Note this is an issue for a new feature not yet merged and doesn't
> affect any existing codepaths.

I think we can summarize this to "in preperation for some future work where
ordering matters with respect to jump labels" or something like that.

Because that is then making it specific to the future use case and
creates the current justification.

> We could just move dynamic_debug_setup() earlier in load_module(). But
> let's instead ensure the ordering via the 'priority' in the module list
> notifier.

"becuase the notifier for jump labels jump_label_module_nb uses a
priority of 1" or something like that would be nice to get added.

> This brings dynamic debug more in line with other subsystems and
> pulls code out of the core module code.

This should be the main reason for this change, as explained in the
commit log. A secondary benefit would be it fixes the first future bug
mentioned.

With those changes I can take this into modules-next to start getting
this tested sooner rather than later.

  Luis
