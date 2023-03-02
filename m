Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49EC6A7B9B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCBHFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCBHFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:05:44 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0AE43933
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 23:05:36 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id e21so12846616oie.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 23:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677740735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Oqwp+VpAaSysismZ5Bnaot6oluqtPG8asyXz/N1Vdc=;
        b=IHLGKSA81OyE+FtjoGk+SaYkNwhgTgWYrtXzl5TB1+Srq5yEAJYjkezlyhX3UUT6KV
         vyt+rbqJmX2IjmtEsYFb55VYR25YocbKt7oC5MKKrr31pSbSW8V2ElQHovcPIyTfjMO2
         6yRypRhVEIed4YrNsOwGNCNcR5VrPyfzTphY+axEHUvWlgJnLX32PJokRV8U5P+SPFk2
         gteRJTgebNyhS+zVZK5MLmZFox/D0/gGpGGY7OpI1vEMvF5FQFcMR3FXhlc/AYAjbHjm
         9gurbrYtvPv7YZNuyZX5HKXaTJ/oYxpLxuWaJDBoMG+TztSr92g13RDiQ7TnhsVZGfg/
         BEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677740735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Oqwp+VpAaSysismZ5Bnaot6oluqtPG8asyXz/N1Vdc=;
        b=brD8Ls2tPozKSXZap3Gfx6LfxnbRhrHeSb92wsx/u/NW4Y1B7gZ4KfaQGz2purNK90
         5HHY8TcdsUiTMMs0zTTcmiVNcq8cvM4Vuc3qZ33Xh/oU30wQq4PJd7kQf+D2MF4AAZvG
         LAdUJeJm7rnJfu4uqRIpgH72SfhaBE9t5h/7CBmpsWj2LAn80ieN1LjwoSFLRfYaXjnu
         TnIb8ueMYlaKzx6c1/qpa8MwiVriVCcbBkKtEMadeApAEGZjjwt7X+3qUA5blmS0jbsW
         kQh/loxqyKbkxcQKGL+4PBAsYwP4TzPTSsVfk+Xqm+q+SwmwfPzHdxL04sDVp0i+gNZ4
         LFLQ==
X-Gm-Message-State: AO0yUKV413xfufILnRxKCP38Q8wdi9rj0cP64EOh/SLzUr8aRFXt65ki
        6TGA4tpXqTUET3I94kyFOCQ=
X-Google-Smtp-Source: AK7set+Xlg4Fr6NlTSUDvRz/dJWmYqYlYwAs4wiQzypOG0cVPcy8aU7BuZyK4m3UnyD4zsH5xVpHrw==
X-Received: by 2002:aca:1216:0:b0:383:b2c0:4f61 with SMTP id 22-20020aca1216000000b00383b2c04f61mr4989805ois.43.1677740735220;
        Wed, 01 Mar 2023 23:05:35 -0800 (PST)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id k204-20020aca3dd5000000b00383e305597dsm6693043oia.23.2023.03.01.23.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 23:05:34 -0800 (PST)
Date:   Wed, 1 Mar 2023 23:05:33 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, shan.gavin@gmail.com
Subject: Re: [PATCH] nodemask: Drop duplicate check in for_each_node_mask()
Message-ID: <ZABKvSq9TQxxQnu7@yury-laptop>
References: <20230124000243.415621-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124000243.415621-1-gshan@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 08:02:43AM +0800, Gavin Shan wrote:
> The return value type is changed from 'int' to 'unsigned int' since
> commit 0dfe54071d7c8 ("nodemask: Fix return values to be unsigned").
> Besides, the conversion between 'int' and 'unsigned int' on the
> parameter @node is guaranteed to be safe due to the limited range of
> MAX_NUMNODES and CONFIG_NODES_SHIFT. By the way, '(node >= 0)' should
> have been '(node) >= 0' actually.
> 
> It's unnecessary to check if their return values are greater or equal
> to 0 in for_each_node_mask(). Remove it.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Applied, thanks.
