Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE536261D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiKKTZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiKKTZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:25:00 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD7967108
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:24:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so8567885pjk.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AxDp+EkD87kpMInKBl+LqOH4m+/gAkqQGadUGYz6imk=;
        b=JrBJh1AMaFf7HysUT/6UJQF/qbl41OarMhYVo2i7ZxjMRLJP1h1K8Q5HOy9xWBmQ0D
         5iibihGVOWSQ5Vtz5BP61jw1fAoe4i/F3UJjMQo52Lxm9nQ47LQZupdPYjztg6jMWx+H
         T68KrUeOo8N+5w5qNvHJhMpbONZo3Rd8jjPHxSnV0lYzBfEZug9yss5TWUseTqnUGJp4
         qNW/0FP9XXn39yTGOKFdheWOK21FMDuxjQK8Fc+5yolQqM8Ym9y/Jv/AjnFrhxV6JVpg
         +m2QR/JMGHF5Ib8vum6EYpDkwbIpPVpFm0EWeLyfZw70mvt6plT248T+DbnNaa6sqIzP
         nLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxDp+EkD87kpMInKBl+LqOH4m+/gAkqQGadUGYz6imk=;
        b=oA/26z4Hi2Tnd34TnxRD1oCy+/LydnD+1BrYnc+ht6Y5OBiaN1i7WdqJ1l/21XvXMO
         W0+8FHJQDJ58YwgVZb4I2cq/4qxFW92yhrH6MdXVYrHjoJVC0jCFSAs0BUpi4h2yeb3d
         CaSN8UtvWDUSR5pneQHvvLtZr1B9VhNnciXXp7O5pQiRexGnRw/t0S1gvBaX9dh3D8qd
         OVX9d/R6kokqp/SvBhOb6Izss0qP63o/qhDF+hRCj918PaeyU/S84mhYOJIIf3Y7eTe6
         E2iJjqjE1NN49Bg5xfNITo0oPEWb+FtvUr4lgPcfVfPhFWT+Ycpm0xNlxv8Q5J3pYpoT
         EZ1A==
X-Gm-Message-State: ANoB5pnSZQnQdMOo1MkRCaz9HWNU/gfnM7CgKbeaBLT01kQvp04gXL8s
        7vrpX+kEpzJnF5OzocwJ5x6RHUI5zQgRzw==
X-Google-Smtp-Source: AA0mqf5ZbausSSTGDH3GxyU9FLxKQpB98WwClDgs3zQB3EW0Q+QDIUfV4z8lo4t6hYoLbkbz+nB74g==
X-Received: by 2002:a17:90a:d70e:b0:212:f52e:55c9 with SMTP id y14-20020a17090ad70e00b00212f52e55c9mr3443412pju.56.1668194698948;
        Fri, 11 Nov 2022 11:24:58 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902eccd00b0017f9db0236asm2103301plh.82.2022.11.11.11.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:24:58 -0800 (PST)
Date:   Fri, 11 Nov 2022 19:24:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH 0/2] KVM: x86/mmu: Use page-track only for... page
 tracking
Message-ID: <Y26hhw8yD96Z4eZf@google.com>
References: <20221110014821.1548347-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110014821.1548347-1-seanjc@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022, Sean Christopherson wrote:
> Don't bounce through the page-track notifier when zapping+flushing SPTEs
> in response to memslot changes as the need to zap+flush isn't strictly
> limited to page-tracking.  With that done, register KVM's notifier on the
> first allocation of a shadow root, as KVM's ->track_write() hook is used
> only to react to writes to gPTEs.
> 
> Aside from avoiding a RETPOLINE on emulated writes, dropping KVM's internal
> use will allow removing ->track_flush_slot() altogether once KVM-GT moves
> to a different hook[*].  Tracking "flushes" of slots is a poor fit for
> KVM-GT's needs as KVM-GT needs to drop its write-protection only when a
> memslot change is guaranteed to be committed, whereas the "flush" call is
> speculative in the sense that KVM may abort a memslot update after flushing
> the original memslot.
> 
> https://lore.kernel.org/all/20221108084416.11447-1-yan.y.zhao@intel.com
> 
> Sean Christopherson (2):
>   KVM: x86/mmu: Don't rely on page-track mechanism to flush on memslot
>     change
>   KVM: x86/mmu: Register page-tracker on first shadow root allocation

Don't merge this series, I'm going to (hopefully) send a (much larger) v2 that
more aggressively cleans up the page tracker APIs, and will replace patch 2 with
a completely different patch.
