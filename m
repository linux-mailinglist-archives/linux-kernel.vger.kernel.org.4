Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8E969932D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBPLd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBPLd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:33:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116F61B54D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676547190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fN8NkOdWNPNgUUyDpAWON7BPuwgG0ESBRyhE+Z23ONs=;
        b=fjxQ/MjVz/yfmzY9EvqqZ+jSkzEmNqZr4gXOsZJConCjY41IRWHJ3+JhLtL0bCltjpu+No
        bsWDoS5/AWscwQ331ULuHSHZtiTkukDtGINPAwzxzOvbs5zq7kMKV6yRq61d4X14QCaxoZ
        snfcVZhhiJpF9Ndu2B4VxkiSjwIkuGU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-a8rTwL2GNcK_BSIN63xmDA-1; Thu, 16 Feb 2023 06:33:06 -0500
X-MC-Unique: a8rTwL2GNcK_BSIN63xmDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89851882824;
        Thu, 16 Feb 2023 11:33:05 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.195.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9B7F1121314;
        Thu, 16 Feb 2023 11:33:03 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Hanno Zulla <abos@hanno.de>,
        Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230211-bigben-oob-v1-1-d2849688594c@diag.uniroma1.it>
References: <20230211-bigben-oob-v1-1-d2849688594c@diag.uniroma1.it>
Subject: Re: [PATCH] hid: bigben_probe(): validate report count
Message-Id: <167654718338.255038.8270814886921394655.b4-ty@redhat.com>
Date:   Thu, 16 Feb 2023 12:33:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Feb 2023 00:01:44 +0000, Pietro Borrello wrote:
> bigben_probe() does not validate that the output report has the
> needed report values in the first field.
> A malicious device registering a report with one field and a single
> value causes an head OOB write in bigben_worker() when
> accessing report_field->value[1] to report_field->value[7].
> Use hid_validate_values() which takes care of all the needed checks.
> 
> [...]

Applied, thanks!

[1/1] hid: bigben_probe(): validate report count
      commit: b94335f899542a0da5fafc38af8edcaf90195843

Best regards,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

