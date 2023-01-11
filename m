Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19734665518
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjAKHY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjAKHY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:24:26 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC48E030
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:24:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673421862; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=kAKScusaIEiBKwYSrMJvC+chJD2GAtRauXp/TF1UwGao6ezSgF/7Uo2KQwHj3R/LC9COsANPH3j1fRNVfD26x8qXtMBPTW6SNI4Lx8rvMklv/kaQOJHBd3IwFChY64fjxDN5TxMTJuA2mwaaRicrUFeE55c/uc0DsiOCDFZ7+pQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1673421862; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vgGGdGFis0D+DHpktD0JWYeIwnQxhZndacWP4HJqdK0=; 
        b=UMQ7jE56ChElzeqKm6gaH7nQk4CknyktmfJ9mzl0NrN2uzMG5rdTs4y61Be1LHJh3r75sLVkenvg/uYSUst6I7bno7T2xQ9KBN5w/Zxzs6hNp8vSxlkLIFImJM6qgU4PTFHUHvg/YqQhp0Wcgjle4RSzh3YGsFZY4TRo4R9ZoFg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673421862;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=vgGGdGFis0D+DHpktD0JWYeIwnQxhZndacWP4HJqdK0=;
        b=DNdujzz5g1pmIW5G+/Wdu4AU80Amt7Dpkl46O0Ntiluqt8/hggBpXfSrUDNhcuGp
        M6WTjNcyWDqoOPmhpfcQUIoltrkG3fyepDCOa/tsVuj4yHOXdfdP/4XhTE3ZdpjdzIn
        vkTv9JWGqA5RCL7bxw8Ji57VYkzYwivBTtIqDe0U=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1673421860992721.8938183625243; Tue, 10 Jan 2023 23:24:20 -0800 (PST)
Date:   Wed, 11 Jan 2023 15:24:20 +0800
From:   Li Chen <me@linux.beauty>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "rafael j. wysocki" <rafael@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1859fb7306f.116a8646a961741.7679135125847887822@linux.beauty>
In-Reply-To: <Y75Wbya+U9F9UPJO@kroah.com>
References: <20230111061541.3657154-1-me@linux.beauty> <Y75Wbya+U9F9UPJO@kroah.com>
Subject: Re: [PATCH] debugfs: allow to use regmap for print regs
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

 > >  void debugfs_print_regs32(struct seq_file *s, const struct debugfs_re=
g32 *regs,
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0  int nregs, void __iomem *base, char *prefix)
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0  int nregs, void __iomem *base, struct regmap *regmap,
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0  char *prefix)
 >=20
 > This is confusing, please just provide a new function for regmap instead
 > of trying to overload this function.  You can use the same function
 > inside the debugfs core like this, but never export such a complex set
 > of parameters to actual users, that's just painful.

Thanks for your review, updated in v2.

Regards,
Li
