Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EFB5F5DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJFAVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJFAVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:21:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B2F7E30F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:21:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a26so575051pfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/qBKORZtms2bTkZoXsWhlC9/6RpsMQQlPOAxIcYlGk=;
        b=c2qKijirYjsZ69Ah4k0WN+wrGry4ewCU+IuoTxyRXIVK2ES4YXYzc0AJc9QbtGJYDv
         bFfo1t0V0O3T7ImNURIVB2AFgmU+olhGl+ErTALhPBHnTHZkDxhwfKJpy2BOQWoAAop7
         pfZjizdxWVFEJw+jCVYLCnIAz/Q5kZ4WkWeN4GuqeFwKqn5HkcP+FvSGEOZddYG5pemq
         rGzYbyCXzhn3okL5vzNbaiIcEkdjy2P592cfxWGGAYfCIZ6YbuP2BEY9ip4KSIycP+GT
         fPs3nMIGuL/lKAoTfLwivV+y2KCcUBI/xxwNGZZCMVSs+sTHhfP5MLgCOaMw/MADpx51
         krig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/qBKORZtms2bTkZoXsWhlC9/6RpsMQQlPOAxIcYlGk=;
        b=I4OtrfTGGMT+YLvqLEB+B09jA8LGMmtFjS6WqDKZzyuwr3DOv0d4ObKCQwd07mxxLl
         oXyaxVRAE5J5VL9WY6s9SpLLljlUzO3S5Ga0Vc7MkyJBdu7K+gUhjXDW9skBRJHL24Pk
         V7s1RDmPLkHFRpr/0VTior3eMIfzYGAJ9S0VRJHQwWLKaLJOBAglrpALbwqEOHMq0D91
         LV7rH//35a5RsuZ4VA6XfgsBf0gu16uq7l7HrlN829iHT1hUUoUKE9T+k0wRtV6Hk98J
         cOLCVWfiLGdhCXKhlkB4djul1wbHfXuEDlMDRFN8dRZa+AU6bz67Ze+OZg9AXKPkSCpk
         A14g==
X-Gm-Message-State: ACrzQf2UpdpIsQHiWA04NwUpcaNU00hVzAnR0DKaJ0CxX+36GeQ/StDo
        rBFUmCjmsHdd36el/eiS7wL2xGt4IbA2/Q==
X-Google-Smtp-Source: AMsMyM5U398swJ3hL0VBqOMmCJQM5iXecYHKlVbx2tEKWecELFstQ3h0dTMpzI5YR+QZC9b3Yzqxrg==
X-Received: by 2002:a63:4f4f:0:b0:434:b9db:b9f with SMTP id p15-20020a634f4f000000b00434b9db0b9fmr2109069pgl.438.1665015691617;
        Wed, 05 Oct 2022 17:21:31 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id iz6-20020a170902ef8600b00172c7dee22fsm10941845plb.236.2022.10.05.17.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 17:21:31 -0700 (PDT)
Date:   Thu, 6 Oct 2022 00:21:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Li <ercli@ucdavis.edu>
Subject: Re: [PATCH] KVM: nVMX: Inject #GP, not #UD, if "generic" VMXON
 CR0/CR4 check fails
Message-ID: <Yz4fhz3UBJGwOuvN@google.com>
References: <20221006001956.329314-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006001956.329314-1-seanjc@google.com>
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

On Thu, Oct 06, 2022, Sean Christopherson wrote:
> +	 * Forwarding the VM-Exit unconditionally, i.e. without performing the
> +	 * #UD checks (see above), is functionally ok because KVM doesn't allow
> +	 * L1 to run L2 without CR4.VMXE=0, and because KVM never modifies L2's
> +	 * CR0 or CR4, i.e. it's L2's responsibility to emulate #UDs that are

Grr, s/L2's/L1's.  Fixed the comment locally but didn't commit it before hitting "send".
