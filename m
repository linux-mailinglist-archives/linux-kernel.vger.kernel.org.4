Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F185672DFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241903AbjFMKl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242029AbjFMKlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:41:21 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E481734
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686652874;
  x=1718188874;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=asTNTnYftoZffO81bVBJAcD6pQPBR+6pQ0HzKkJz57k=;
  b=Sq18T5z9Qrt89q/CHBCtLXbd58Hoj1dllBuVLdJjUXIEtgq0M9MIqXFC
   ja6P2aihX6FTyIKST9e2GlJglsMCROR6RQDGOdP4Wj/kTLlJhqB5nqq3G
   smKCbswF6imNqpA/kjRW+TT36PSYJVUy0KZE7ghXLIZeDNXGSSalisLgP
   SZS6RN+CacmBlVzifHNPMWdp5VDUvzINCL+F3u3ItylGxsLVsN0tlXlSH
   jT6AD6qqbYyAbSCI2rXDNjkErOIWj+cY9AOG1x6PSSPB4/Nwvhhnot8SY
   REA4EUgvs4QiXo2J3NDx+K6y5ORK3SWFBQcxTWjPt20Evgsko8eR0AkeH
   w==;
References: <pndttvcu3ut.fsf@axis.com>
 <443d4c43-080e-48b2-80ee-13e2df10c6eb@sirena.org.uk>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH] regmap: Add debugfs file for forcing field writes
Date:   Tue, 13 Jun 2023 12:24:28 +0200
In-Reply-To: <443d4c43-080e-48b2-80ee-13e2df10c6eb@sirena.org.uk>
Message-ID: <pnd5y7rabll.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 16:00 +0100 Mark Brown <broonie@kernel.org> wrote:

> If we're going to do something like this which could interfere with
> driver operation then it should be guarded like the write support is so
> that people using it have to modify the kernel to get the feature, or at
> the very least taint the kernel.  This is less invasive but still might
> cause issues if someone is relying on read/modify/write behaviour.

I understand your point. Should we introduce a new macro like
`REGMAP_ALLOW_WRITE_DEBUGFS` (which requires direct code modification to
enable it) to guard this or introduce a new kernel configuration?
