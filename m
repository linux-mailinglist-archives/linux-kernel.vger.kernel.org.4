Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF84613DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJaStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJaStk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:49:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40BC13E02
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:49:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m2so11137175pjr.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lxm0tOK3Vx5nF8SDGL3j6VCEiNOGUWGpFOfZSVRl4Q0=;
        b=dOy7Jsm/Wvr5hNNq9vJEoD4OWCeXsBR7deJofjuBIAcUc16ebM7ARjXPnheoVsxbF1
         ZG4Mqgqbo4eZioe04nZ6HTuoDg4PevCGUcBQcu0soYHhKyEuxreepQ/GnsEPzFjFaaxb
         Z5gAt/IocAfwIpR12qVY5NH2K13ckqtcJvEMAGPF/q8FOrpkX4qkk4cyOzSfnyoGPuTr
         tdEGURD9OqxMuCO1gnM7SGnhYvAver2R7/nfCULexsz8ct6l2Yu5TGFUAwv0NFa4jwN5
         TIGfLTuzl4c7v7kxRanXEW9X2fooUmE2LOckFSvU7QLnE3FFvIwNl7KoOvOuI5/FOm+P
         OZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lxm0tOK3Vx5nF8SDGL3j6VCEiNOGUWGpFOfZSVRl4Q0=;
        b=R3nP8XvGSZY0VlPtuAsJYEK21ymuxG2ruWDI0Lcb1XXUbLM45SubCt6y3aj779LDQr
         jyHx92jCcWagHzksMTQkB1ewKMHkIadNAbjrz4/d3Eusj49cTNJZ+34+3BNnbQXHKqZA
         fH4D12XIrC/IneKSTx0uGovbr8r8Dkh80bNq0Ih5ih6h50FrXthCOCPRDxcAJTdYI8+6
         WEX8TaBNBCLCelXyJaqG9qLBTOc55G7co9y49skSJVjBZ6H4Ybrom4VK3TuqhPLOGdf/
         CT36raha/lUf5CHJfSoS2kerhdGMHVbF73sJHglxErbWXXFZMpqxBha/fDRvxvZgykGl
         mTjw==
X-Gm-Message-State: ACrzQf1zKtzWdU6GjUQ452CCepZRSoiLxxyvb8prvWt45l6d8oTcYU9Z
        SF/D8kVyxRRljOgh+wdPxAeXBg==
X-Google-Smtp-Source: AMsMyM6obrQ+rSpRYZSJSEMaps9fWGsBRg5Sq4mtrzU1VePgVAgQt9XJE/98esyY1+dNNInPUs0qEA==
X-Received: by 2002:a17:902:8e88:b0:185:3cea:6335 with SMTP id bg8-20020a1709028e8800b001853cea6335mr15749373plb.96.1667242179135;
        Mon, 31 Oct 2022 11:49:39 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902c40d00b00174c1855cd9sm4779726plk.267.2022.10.31.11.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:49:38 -0700 (PDT)
Date:   Mon, 31 Oct 2022 18:49:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, dmatlack@google.com, andrew.jones@linux.dev,
        wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/5] KVM: selftests: Add atoi_paranoid() to catch
 errors missed by atoi()
Message-ID: <Y2AYv30usDTHRLKB@google.com>
References: <20221031173819.1035684-1-vipinsh@google.com>
 <20221031173819.1035684-4-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031173819.1035684-4-vipinsh@google.com>
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

On Mon, Oct 31, 2022, Vipin Sharma wrote:
> atoi() doesn't detect errors. There is no way to know that a 0 return
> is correct conversion or due to an error.
> 
> Introduce atoi_paranoid() to detect errors and provide correct
> conversion. Replace all atoi() calls with atoi_paranoid().
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Suggested-by: David Matlack <dmatlack@google.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> 
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
