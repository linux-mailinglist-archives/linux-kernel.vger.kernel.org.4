Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F3B5EF6EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiI2Nvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiI2Nvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB721432A2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664459498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IieW/qrMKIIc8eu7bzdu8OnHs0kBWGnniYBMz77goME=;
        b=Vl8BdjECU+Q6hBAF5S537awrPizrlRH5aoqgkhv/+UZQ5hHlhvPpKPEZt5d2DRBGL3V8AB
        guYGV3BXWWuku1IjK+HmP1pXGxYcz+JvStYR1b1dx/8rJjSxOWQxuH51Gq4Pm+bCh/NJuo
        Xr+nj+oiz62PZH2X3/0WLAHy3Oicbw4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-674-cEraDkRrNv2ClVUsig3rKw-1; Thu, 29 Sep 2022 09:51:37 -0400
X-MC-Unique: cEraDkRrNv2ClVUsig3rKw-1
Received: by mail-wm1-f70.google.com with SMTP id p24-20020a05600c1d9800b003b4b226903dso2987222wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=IieW/qrMKIIc8eu7bzdu8OnHs0kBWGnniYBMz77goME=;
        b=ygsXh7pTKyVt8fRbQ8vXnae4bjeqKDy/UusKJsYqzwSaJXclSttBcwYX2csqMW0MXE
         e3FsDTCx3IQjWT+LsOe0ULrWI92/a9oPbUT12DCuBQKHlfmtnUYl5XusNwreCQ2+HjHn
         jQpJKoQL2rZC6mrvkHvYVyFsB4FqHjphSa4uWBz3aEX+HhdE1K0W0npr/x1sf1ym5LzZ
         XUjnZcBN+zt6PKK99zCZ1eaPcL4B6tLRjcc3LsSD3X8v4W14cdb2yrT5qCR9y1r098/b
         y8P8Wuj3YGB2MQCvq1ykMwyKzKkT76MMiqgTH1fBl9hI1JyebnFxF2R/1EwvLf9TVmc6
         GyUg==
X-Gm-Message-State: ACrzQf2SGtqcc6YrN/5EBdZsMx1NjvIiGSwew5acT1WjM7gxpnaXRtBG
        YFvvGnZH+qw2Ur7IE7gdWEDA14GU1E8IxXQBIme00KecpgvvlvSTXwAuV3vqoLXKNygsVdnSxx4
        eAXntwdh6q7VTPbKQuhtyucY=
X-Received: by 2002:a7b:ca46:0:b0:3b4:7ff2:1ca8 with SMTP id m6-20020a7bca46000000b003b47ff21ca8mr2470541wml.11.1664459493472;
        Thu, 29 Sep 2022 06:51:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6BYA3SexgjmIbaHkskwniQiLaOlIBd8lGcGdjTQL2j/REfB/Qz243X0n7EN+MLVyG0I9pdOA==
X-Received: by 2002:a7b:ca46:0:b0:3b4:7ff2:1ca8 with SMTP id m6-20020a7bca46000000b003b47ff21ca8mr2470525wml.11.1664459493312;
        Thu, 29 Sep 2022 06:51:33 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id h18-20020adfaa92000000b00228dd80d78asm4662657wrc.86.2022.09.29.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 06:51:32 -0700 (PDT)
Date:   Thu, 29 Sep 2022 14:51:32 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, joro@8bytes.org, will@kernel.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, hpa@zytor.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        atomlin@atomlin.com, robin.murphy@arm.com, charlotte@extrahop.com
Subject: Re: [RFC PATCH 1/3] x86/boot/e820: Make __e820__mapped_all() external
Message-ID: <20220929135132.6qpit2dspyhs54vg@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220611204859.234975-1-atomlin@redhat.com>
 <20220929082551.2zrsayd2v3xhot7m@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929082551.2zrsayd2v3xhot7m@ava.usersys.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-09-29 09:25 +0100, Aaron Tomlin wrote:
> On Sat 2022-06-11 21:48 +0100, Aaron Tomlin wrote:
> > No functional change.
> > 
> > This patch allows __e820__mapped_all() to be available for
> > external use, in preparation to enhance the error message
> > generated by arch_rmrr_sanity_check().
> > 
> 
> Any more feedback?

[Adding iommu@lists.linux.dev and charlotte@extrahop.com on Cc]

-- 
Aaron Tomlin

