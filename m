Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4351729FA4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbjFIQHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjFIQHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE6435AD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686326824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5J35VrNmjkpODYInc7dhrWj/0vYQzkKJNessU6AYz9Y=;
        b=bP8t4KI+C7fn16u7jhaW2HkXk1AH7VXn+lyR8Np7eBmcK9pWpNDiORo/pZgX3UU7Gk0o1X
        mhENbjrsCJiiGMJqJZiNWmKUBic0AiBRujJlfuzjxqQ4awN8WTI6/sSQ5Lg+9h8WHwytZo
        8sX9y0W2hnL88pRLtKTQF88fnA9rKUE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-jc1YLj--M1G5UWfL-gshGQ-1; Fri, 09 Jun 2023 12:07:03 -0400
X-MC-Unique: jc1YLj--M1G5UWfL-gshGQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2f2981b8364so1034581f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326822; x=1688918822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5J35VrNmjkpODYInc7dhrWj/0vYQzkKJNessU6AYz9Y=;
        b=foJEL27XPJYMSWSvXEL+asqT5152mIdrECH0XxBwsE8SYhGv/hSrMPnP445DiSn1Z5
         +MfUTX9O2mVOPpb6jgPTuDo1xupWWiwUpYmUMUrjyZs3Iu0VvX7yjtGRoVCjWWdwiGWG
         pI+NHlJ2Qmdrc49AbzBK/lTtTfErL8wQq7p2H0/ShgnBT8tLnZ7OJ/LXGC6BFiF/jXRO
         oNmHntlxwgo6g7CTjxA61WyEg3zfeVid/vSEQe4H+UyWnLK1DZ7EOXeJwwZebzXmBx3O
         46fNx3/VHRgCiUVre1DLziPGGCGTGKSsHWyCUkAdFc1ofWHuU8os0hwlnkGDGBxstaSc
         kb4w==
X-Gm-Message-State: AC+VfDzYUdsB/gk3Ff2LZ0v2NOxymOiKn+JWIkbla8nLRtL0xLftyCHH
        ykGhMzXmuOZjkXSY2z60co/2+cXVr/YXJKrSeZaTTfZkjUpBmYoK2cSc0CNBAJku8Ie6jmVQHnC
        +3Rgzu8KP5TFs8rY9ew7/2GPKFK58bc23
X-Received: by 2002:adf:f3cd:0:b0:30e:3e9e:207b with SMTP id g13-20020adff3cd000000b0030e3e9e207bmr1298066wrp.32.1686326821882;
        Fri, 09 Jun 2023 09:07:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6DeQtK3V76CSYnkOLZjiyDe1V9OpmIcOUfGabiu2EYTXXG/qEevQqBoZxHqU1eCbAno6PjKA==
X-Received: by 2002:adf:f3cd:0:b0:30e:3e9e:207b with SMTP id g13-20020adff3cd000000b0030e3e9e207bmr1298046wrp.32.1686326821563;
        Fri, 09 Jun 2023 09:07:01 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6e8f000000b0030e6096afb6sm4894148wrz.12.2023.06.09.09.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:07:00 -0700 (PDT)
Date:   Fri, 9 Jun 2023 12:06:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Roberts, Martin" <martin.roberts@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>, Suwan Kim <suwan.kim027@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] Revert "virtio-blk: support completion batching for
 the IRQ path"
Message-ID: <20230609120622-mutt-send-email-mst@kernel.org>
References: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
 <BN9PR11MB53547AEE6DAB355D5C04BFE98351A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <20230609054122-mutt-send-email-mst@kernel.org>
 <BN9PR11MB5354B884C2C89BB6AF1092B48351A@BN9PR11MB5354.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5354B884C2C89BB6AF1092B48351A@BN9PR11MB5354.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 09:49:18AM +0000, Roberts, Martin wrote:
> OK, I didn't realise you had updated the patch; I only looked at the first one.  I think you did the same as me, just changed vbr->status to virtblk_vbr_status(vbr), in virtblk_poll().

Yes exactly, though testing exactly what's on list is always a good
idea, just to avoid confusion.

