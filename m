Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69706CEE20
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjC2P4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjC2P4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:56:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBAA6A45
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:55:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t4so11030331wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680105278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p/ajfvBQTErdVHrQqdHTV8eJEA/8/+bHBYeF2lwVNsg=;
        b=SOkFAsluPYOQnvWnrI6rJWoGQCnPbGS4aPRnkzovQR9VqxnEUy0RXhloFovA+8rqKn
         4tjySc4vKqnSmZo2NsDpADZ+2w/ZgOqg3xd6zSCXolYkZB71bMPXl12m/XMQpXnpXGg8
         I2U55HCmBQ6I+ky0/6zXA2J3/3GxN/VO+1JuWMgBEWf/WA2kIszLZrHji2mLoZ8qBwvz
         PBxWci7BcAWgM2tfy48tRjM2vYhYj6pWwtXTztz+hkCIknYAP/7cmXy/ZUe4O3RXXPCP
         1vWBYR/+icccwZHPv5Ds0p/b+hy4Sn4rT0dNNrZgtVPuFGoJRNvEgqG5fD52Iowkd2cI
         hYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/ajfvBQTErdVHrQqdHTV8eJEA/8/+bHBYeF2lwVNsg=;
        b=XlpL4gR3AQEfiRYxdVU+mfHWO93qXgcfOenpPLxMNozSN0Vs09VNYC6jgJ0aDUL/T7
         SsMnDEtXMQ2J3SQ4RgQLCHUox2o85bWC1q7fPKFJGVQ+vIub+bNLQppOQDx2CChonAEF
         liaxNB2DQLy5Rg7QKVPiVR63PO0bDvvdviG4sUW+vCfQ8OJuwPZnxQ3GqQW50C0cDEFY
         vy6Qm7U7rp1Rm8HuK/XS/0AFU2/NypCUq421TyEKElZhCps8hJ4ltoXVMGwZxuCONdWu
         tzkjArPG0Pduo7i6rqEHuEEsN1VOqqRnGT8m1BolN7uI9UVvZD9JIrM9V9jgeez5DBRZ
         QL8g==
X-Gm-Message-State: AAQBX9efim9jupfGssOoYBecSoHMLXmrfxT+OPQlcRMrXe6FwbxM78RN
        VO7NPmc9IhAYgIsqGzZT5R2j2HM39ud4tMCUxFbqpQ==
X-Google-Smtp-Source: AKy350bZjUGZ5mB8SlUqYKNONLA6YYADNEZJnQbwe5vggCnXNh5UgRb/q95EJp+tyIQuy96P6c2pkQ==
X-Received: by 2002:adf:ec87:0:b0:2d1:46eb:3f98 with SMTP id z7-20020adfec87000000b002d146eb3f98mr16685731wrn.36.1680105278598;
        Wed, 29 Mar 2023 08:54:38 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:e994])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d4e8d000000b002ceacff44c7sm30650177wru.83.2023.03.29.08.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:54:38 -0700 (PDT)
Date:   Wed, 29 Mar 2023 11:54:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        surenb@google.com, brauner@kernel.org, chris@chrisdown.name
Subject: Re: [PATCH v4 3/4] sched/psi: extract update_triggers side effect
Message-ID: <ZCRfPYKqIJpLxGJM@cmpxchg.org>
References: <20230329153327.140215-1-cerasuolodomenico@gmail.com>
 <20230329153327.140215-4-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329153327.140215-4-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 05:33:26PM +0200, Domenico Cerasuolo wrote:
> This change moves update_total flag out of update_triggers function,
> currently called only in psi_poll_work.
> In the next patch, update_triggers will be called also in psi_avgs_work,
> but the total update information is specific to psi_poll_work.
> Returning update_total value to the caller let us avoid differentiating
> the implementation of update_triggers for different aggregators.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
