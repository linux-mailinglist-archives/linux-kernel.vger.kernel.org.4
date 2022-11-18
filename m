Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A24A62F9E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbiKRQEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241597AbiKRQEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:04:20 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D26716E2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:04:20 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id b62so5419958pgc.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SlFVrej9bt4YEUqyZWryuI8fTcVVTeK+6ZolSLExKOo=;
        b=HvcoXdH7ttv9Bf+uw0Ns4EN0hYL9WLK3zx1ep4D98FrWoNLmOjfRcYrS8wv95bHTU0
         dUZoP3H+9NjYegMqMpD30OiZgQjjM/tWjdAbToHWmRqO5pdKdDINR4EXe2F/bS3lmbcA
         w7BxwfcPHZE6gd4PPAHBfEgcexn55aFwgnLHAnXwR0rlvie0Jlp13SX3MvdWKcLS9TF8
         U41ADoXkBU7BcUovJlp0QvwHja0S9Yhra7rn/nJCZeoXgTsr+lx4F12wYd62moC6FLX1
         KXNDigpp/8AAm2cekP7Xm8gP2KXiWH7ABMOzM38IF7dIZvHFaDbli8kWQf3QfTnJGSHJ
         rpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlFVrej9bt4YEUqyZWryuI8fTcVVTeK+6ZolSLExKOo=;
        b=uWZsl8VSINMEOwiZwdYXClndaa/d2irHNBQyMfd88pNJIQP+zGbocEbqBpvz0JJQzC
         zJjgUw9Yl4IT9t7rbAmJWqytH1DaENF3VbQkjAhZoxelhALLwh57LazMCaI2u+15NEcq
         trVMuBoe0MNk6JOwEpFAT7pbr31eWdf+Bxt0KM2d8aFRQ+ezGVZjQ4cIUAHXKWnabGiB
         +tH8k9o8D9d4Y3gF0BH4hewdPbkdr3Gbixv6FwxmApRUvmo736u8e8F2Y5H9AzIPAHR9
         x0qJJ2hbkfkVfORXgclduNXPahm1lRXHLouXTsPeOlrlvlAe4EkBmPxtZvqZKEqPgYP9
         u7nw==
X-Gm-Message-State: ANoB5pkQmtamoh77mtJqnGW518MXj/oND9FjnjEa8rFrV74XIYRCGvCH
        GyFaf/O53cK0F8fM1K/Gu728Jw==
X-Google-Smtp-Source: AA0mqf4zEGFlIGLb7p38iRQ/pYcFzeVxsEZxePUGfaUEEC0R0h+cKILFDnFOOmPBIbr5+jmr+ewFcw==
X-Received: by 2002:a63:d117:0:b0:476:c781:d3ae with SMTP id k23-20020a63d117000000b00476c781d3aemr7072807pgg.183.1668787459569;
        Fri, 18 Nov 2022 08:04:19 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902c60200b001766a3b2a26sm3820057plr.105.2022.11.18.08.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 08:04:19 -0800 (PST)
Date:   Fri, 18 Nov 2022 16:04:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Greg Edwards <gedwards@ddn.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3] KVM: x86: Allow APICv APIC ID inhibit to be cleared
Message-ID: <Y3es/yLTo1dXSzAF@google.com>
References: <20221114202037.254176-1-gedwards@ddn.com>
 <20221117183247.94314-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117183247.94314-1-gedwards@ddn.com>
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

On Thu, Nov 17, 2022, Greg Edwards wrote:
> Legacy kernels prior to commit 4399c03c6780 ("x86/apic: Remove
> verify_local_APIC()") write the APIC ID of the boot CPU twice to verify
> a functioning local APIC.  This results in APIC acceleration inhibited
> on these kernels for reason APICV_INHIBIT_REASON_APIC_ID_MODIFIED.
> 
> Allow the APICV_INHIBIT_REASON_APIC_ID_MODIFIED inhibit reason to be
> cleared if/when all APICs in xAPIC mode set their APIC ID back to the
> expected vcpu_id value.
> 
> Fold the functionality previously in kvm_lapic_xapic_id_updated() into
> kvm_recalculate_apic_map(), as this allows examining all APICs in one
> pass.
> 
> Fixes: 3743c2f02517 ("KVM: x86: inhibit APICv/AVIC on changes to APIC ID or APIC base")
> Signed-off-by: Greg Edwards <gedwards@ddn.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
