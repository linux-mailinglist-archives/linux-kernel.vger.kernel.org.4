Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D79679C62
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjAXOrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjAXOrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:47:35 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872A41BDB;
        Tue, 24 Jan 2023 06:47:34 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id mp20so39577621ejc.7;
        Tue, 24 Jan 2023 06:47:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvhId9fOglLhC4N0PXr8agmQKbuMh/aC+XILERRJYp0=;
        b=bd1LOgl03YpcxGYbx4OOzUB49sP0TncE6CcGMrb5H4DOpqDzl7YOQGCWlFL4Bydz3G
         OuJ4zaskUJu/BJD3D6B6GryKcYQMe8/18kjPP+yLuk0kVs8kaQt5VWanZmq4QmzAJC2H
         OUo369cldQrVhyQUr3fIF4Uh1s5SmY2E5vyER71Z2xHwbFOCGtV2egill7uY1hTKmZXR
         B8CN7dYnH/qHz8P/B/6lm4hhcBVGpW9GFFkYwfjX5ZkPT2rv5MDizVEQVZUSyuVntP/c
         0v9Cys4n0kVXEya6HFJQzBQnxrDkA0Ydcgc3I1PaZK5ZHjksZPWnL89vVX4jFVPLX2Iz
         gtxA==
X-Gm-Message-State: AFqh2kqYQhE1bqcxjHQisVB62AWJWKM+l5eM/ZuQRGRLQiARu8AapCn1
        atVpE3wKNILvatcrZhaKE/XMJ/CAV+Jrb/ejyCc=
X-Google-Smtp-Source: AMrXdXtGJQWYz9rDiyL66zBbTj2dVE+N2xUISXMFqgsJDLvcSq3S6zFWPZZBNWx+JfL6luBwUzPDSlLBbEFTFNICooI=
X-Received: by 2002:a17:906:514:b0:870:6768:ebcb with SMTP id
 j20-20020a170906051400b008706768ebcbmr3418117eja.13.1674571653097; Tue, 24
 Jan 2023 06:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20230107192513.118172-1-tim@linux4.de> <CAJZ5v0jYUmDHn6ati=zOU6JyYYAuc6CUtV2eomPWWa2aBoKdSA@mail.gmail.com>
 <5b145975c781b9a8165acea037192f38f9a6d87b.camel@linux.intel.com> <498ed05c0c4fcd9d1459313279aa4105ff514650.camel@intel.com>
In-Reply-To: <498ed05c0c4fcd9d1459313279aa4105ff514650.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jan 2023 15:47:21 +0100
Message-ID: <CAJZ5v0jRbGZr-g6TLq3NEpZtBBeTDKaEe1un=R2Q4FB=5SFWkA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: pch: Add support for Wellsburg PCH
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "tim@linux4.de" <tim@linux4.de>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tushar.n.dave@intel.com" <tushar.n.dave@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 6:01 AM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Fri, 2023-01-20 at 09:50 -0800, srinivas pandruvada wrote:
> > On Fri, 2023-01-20 at 17:40 +0100, Rafael J. Wysocki wrote:
> > > On Sat, Jan 7, 2023 at 8:42 PM Tim Zimmermann <tim@linux4.de>
> > > wrote:
> > > > This adds the PCI ID for the Wellsburg C610 series chipset PCH.
> > > > The
> > > > driver can read the temperature from the Wellsburg PCH with only
> > > > the PCI
> > > > ID added and no other modifications.
> > > >
> > > > Signed-off-by: Tim Zimmermann <tim@linux4.de>
> > >
> > > Rui, Srinivas, any objections to this one?
> > No objection.
> >
> And no objections from me.

OK

Applied as 6.3 material, thanks!
