Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C175F6441
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiJFKRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiJFKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:17:47 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E5F40569;
        Thu,  6 Oct 2022 03:17:45 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 493BC20191;
        Thu,  6 Oct 2022 13:17:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1665051462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulZzLcfM3/DwXgHVrF0TWczUdwf1FcFxQY1Zo0Gu83s=;
        b=rOPiH1fjMRiRKtfLz5xPob64MeLbsQEnT8xQZLIryrd9V74a8RhBDDua4NohcE2DHq4fUF
        cMwaSvjU+S/uO5m4paD8ZfE5+/HMkJtV1cEe/ej4I7N6Q2IBmuYa9syLeWGjvDRHo147dE
        GtYtB/6ji4lOphmE/Wub48sdUVMTKzI=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id D0A9C634CBF;
        Thu,  6 Oct 2022 13:17:41 +0300 (EEST)
Date:   Thu, 6 Oct 2022 13:17:41 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Hidenori Kobayashi <hidenorik@chromium.org>
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] media: ov8856: Add runtime PM callbacks
Message-ID: <Yz6rRd7fiShSuAmX@valkosipuli.retiisi.eu>
References: <20220921092417.2579126-1-hidenorik@chromium.org>
 <20221006095846.pvhmis44z777fnsl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006095846.pvhmis44z777fnsl@google.com>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1665051462; a=rsa-sha256; cv=none;
        b=kCvfM8DIBW5yD3bDftPGEg9jTD4eBxV4f2ulNI+NjTCBZ3t/470oVynpb0nobVbLnS8TSl
        /YexhTYNWXRKmBWUH8tbjTpM81jK94TpIQTuJpyb+JXior2x8jsxNcm6lPZZeRE5uB2Hqw
        uz5343s3CXI6Z+F3YjyGG7Jpcfkk/0w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1665051462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulZzLcfM3/DwXgHVrF0TWczUdwf1FcFxQY1Zo0Gu83s=;
        b=cH4BLbzOM363s4UpuwJYeH7GQHoL2D4MfkjfamLQ5tXchQLGEYt3n4DGX2gympn8hAtnMs
        Z+XYKVBbI1GZfUC5wMsMIX/F9T+hM0N+gvA2z8qFfhYUzPmH9sQCq9tswbszcY7wQyucT9
        HX0BATgDceX1WFmcfwODWCSHebTzQUU=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 06:58:46PM +0900, Hidenori Kobayashi wrote:
> Hi Sakari,
> 
> Could you kindly take a look, please?

It's actually in my tree already but I haven't pushed it to git.linuxtv.org
yet. It'll need a rebase on 6.1-rc1.

-- 
Sakari Ailus
