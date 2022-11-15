Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D01762A074
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiKORfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiKORf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:35:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565A918360;
        Tue, 15 Nov 2022 09:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xKJI9SOGNy34zKV8aehb6R2QO5TFVEQr7/jH6rpCfbc=; b=XKXMfCzbqhX3BPrpS3eldTlN3y
        sNzfSKUTAT58GfygdyU2TitFCkkqI2QUNl3FttQv5+sYM53sn/sSiO3GUgZbxUAZLnGutQAqQbxYQ
        h9Vo0n4UWJxuBfohz6/KK8OL9sXv0/S7ummuzP/gcSNPrs2zhfM1xr4/K/kTI60L/4ND8T1sonuRk
        S9EWB/ddfCNQ+t0EbXL1Rgv0PJ4LXJQ9VGW1oarIBWLh/woBg8OfmZ2QhijQKIlq8qGlqY4bv3Aor
        mHO/9Vr/Ko4LgE5RERDnvIMhJnu0B4RN6EScZ7PWF7TNV6MaQ1gkOeVvrBn8YHl0f6FXyu0RosuC8
        458//vHw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouzq4-00DWPE-P0; Tue, 15 Nov 2022 17:35:12 +0000
Date:   Tue, 15 Nov 2022 09:35:12 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modules: add modalias file to sysfs for modules.
Message-ID: <Y3PN0GZYvFyUF83g@bombadil.infradead.org>
References: <b2d1004d-4a76-ab0b-d369-a38c2d7c1624@csgroup.eu>
 <20221111152852.2837363-1-allenwebb@google.com>
 <Y26UcbviRaoK9a3C@bombadil.infradead.org>
 <CAJzde06b4d065y7KSoGO6qQBgvcVdkUai1WAy_TkrkTCDHS41A@mail.gmail.com>
 <20221114172214.ilnk5wj3eevpsqts@ldmartin-desk2.lan>
 <CAJzde04id1kWhnR5HfuFEZR+ej7xXAsmQ9HpwYT5rQEY4Jsntw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJzde04id1kWhnR5HfuFEZR+ej7xXAsmQ9HpwYT5rQEY4Jsntw@mail.gmail.com>
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

On Tue, Nov 15, 2022 at 10:05:35AM -0600, Allen Webb wrote:
> On Mon, Nov 14, 2022 at 11:22 AM Lucas De Marchi
> <lucas.demarchi@intel.com> wrote:
> >
> > On Mon, Nov 14, 2022 at 10:42:50AM -0600, Allen Webb wrote:
> > >On Fri, Nov 11, 2022 at 12:29 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >>
> > >> On Fri, Nov 11, 2022 at 09:28:52AM -0600, Allen Webb wrote:
> > >> > USB devices support the authorized attribute which can be used by
> > >> > user-space to implement trust-based systems for enabling USB devices. It
> > >> > would be helpful when building these systems to be able to know in
> > >> > advance which kernel drivers (or modules) are reachable from a
> > >> > particular USB device.
> > >> >
> > >> > This information is readily available for external modules in
> > >> > modules.alias. However, builtin kernel modules are not covered. This
> > >> > patch adds a sys-fs attribute to both builtin and loaded modules
> > >> > exposing the matching rules in the modalias format for integration
> > >> > with tools like USBGuard.
> > >> >
> > >> > Signed-off-by: Allen Webb <allenwebb@google.com>
> > >>
> > >> Thanks for the patch Allen!
> > >>
> > >> I'd rather have something generic though, and it would seem kmod [0] already
> > >> does this, have you seen the kmod support for builtin.alias.bin
> > >>
> > >> Can't that be used?
> > >
> > >Probably, but I don't see the builtin.alias.bin in my build. Is it experimental?
> >
> > no. That is generated by depmod since v27 using modules.builtin.modinfo
> > generated by the kernel build system. Highly recommend v30 though
> > as there were fixes in v28 and v29 and some changes to speed up its
> > generation/use in v30:  See entries mentioning
> > builtin.alias and bultin.modinfo in
> > https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/tree/NEWS
> >
> > libkmod/modprobe/modinfo also have the corresponding changes to lookup that
> > index when resolving aliases.
> 
> I see the file but it is largely missing the aliases I am interested
> in, so it looks like I might need to modify my patch that creates
> buildin.alias to add the missing alias defines in the header along
> with the other module metadata for builtin modules. Does this sound
> right to you?

Can you clarify what is missing and why? And an RFC is welcomed if it
helps demonstrates what you mean.

  Luis
