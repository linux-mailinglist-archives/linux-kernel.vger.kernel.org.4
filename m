Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC2267407E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjASSEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjASSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:04:25 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64789917F3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:04:20 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x24-20020a17090ab01800b00229f43b506fso1586575pjq.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6y9K0iW1kRsBC/mddZwl+2pKXT9gEpvdM6yfT0kkWgs=;
        b=r9fJZq/zeW/QLHylZ/qOklEA+M/ydr2B8xBZjXEwFkHpy0aCVYSMNNy1tD1WfkDOOC
         y6YFPFcgEWjYuansLBaXKQwY4WySvpn56ULo9OdrimOyLnUiv8Gs694/scyejPJUTRTk
         g4SVDYZS4U0FAX3Gulz4JP5os+5PZj1vOpkCwsVYlycEFICQiK/K/HhuCTARMRE5hTUk
         RuqkGhamAm2xNHrb7y3RqpGdPyvj65feiY89D9/ENaMwayIraulyNx8lZgnMWguTB8PO
         U6pI2Pzx+FafGPNz7o3MgeSNR76GTkqm91A/RUXvKUTp07raLGJ2FSYgB4H07tZnc/qs
         sv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6y9K0iW1kRsBC/mddZwl+2pKXT9gEpvdM6yfT0kkWgs=;
        b=BuxYqdce6GmgrfVSJJ5l17MNMykxGJAduX7N945SFFnicTQ2BT0fIK6txqkww/pkl0
         fF60VPLb7gqLCl1ZE38bVQNHfLrO0bP7YFUZ4OWEG/ebpFr52ZmN2d1+l0gljecXlFKB
         PT1O37KrlkxM1KFkufgb69Bf5Tk0ILetihvgyQHlb8MPBOP4ejDZ5u8/qpxzYK2QxYMy
         CbhLo4EUaIf8YOz81tkp46/COlOF5dNPsy8QngOD8HASKGz3Luvrxos8Vq2PPV9xJ0Gg
         kJAFkSN+7nLgKWzuUnsKI5QbuFICFxH+TPFiFZYgtJZps2eU1V0wvcKc9QYi94JARPmt
         v0cg==
X-Gm-Message-State: AFqh2krAI9ZS7aHHtrKAfjL8xAQ+44PaWXBuPurZ/r5VhMgkchXynkDQ
        N6nSqwEw2DRkJp0RElSJetPSpg==
X-Google-Smtp-Source: AMrXdXvGfKSI5zWv++JoNn9fRL7W+6evxSd9BszfHZjsBxMUxXJrxIvsF/j70lLejwfrW/gJiiCmTw==
X-Received: by 2002:a17:902:b10e:b0:191:4367:7fde with SMTP id q14-20020a170902b10e00b0019143677fdemr3136248plr.0.1674151459345;
        Thu, 19 Jan 2023 10:04:19 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902654400b0018bde2250fcsm23931663pln.203.2023.01.19.10.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:04:18 -0800 (PST)
Date:   Thu, 19 Jan 2023 18:04:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH] KVM: x86: fix deadlock for KVM_XEN_EVTCHN_RESET
Message-ID: <Y8mGHyg6DjkSyN5A@google.com>
References: <20221228110410.1682852-1-pbonzini@redhat.com>
 <20230119155800.fiypvvzoalnfavse@linux.intel.com>
 <Y8mEmSESlcdgtVg4@google.com>
 <CABgObfb6Z2MkG8yYtbObK4bhAD_1s8Q_M=PnP5pF-sk3=w8XDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfb6Z2MkG8yYtbObK4bhAD_1s8Q_M=PnP5pF-sk3=w8XDg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023, Paolo Bonzini wrote:
> On Thu, Jan 19, 2023 at 6:57 PM Sean Christopherson <seanjc@google.com> wrote:
> > > This change generates a build failure with error message:
> > > "error: a label can only be part of a statement and a declaration is not a statement".
> >
> > And other flavors too, e.g.
> >
> > x86_64/xen_shinfo_test.c:965:2: error: expected expression
> >         struct kvm_xen_hvm_attr evt_reset = {
> >         ^
> > x86_64/xen_shinfo_test.c:969:38: error: use of undeclared identifier 'evt_reset'
> >         vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &evt_reset);
> >                                             ^
> > x86_64/xen_shinfo_test.c:969:38: error: use of undeclared identifier 'evt_reset'
> > 3 errors generated.
> > make: *** [../lib.mk:145: tools/testing/selftests/kvm/x86_64/xen_shinfo_test] Error 1
> > make: *** Waiting for unfinished jobs....
> >
> > I'm surprised bots haven't complained about this, haven't seen any reports.
> 
> It's clang only; GCC only warns with -Wpedantic. Plus, bots probably
> don't compile tools/ that much.

/wave

Want to queue Yu's fix directly Paolo?  I was assuming you'd be offline until
sometime tomorrow.
