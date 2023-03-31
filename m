Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C8B6D28B3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjCaTdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjCaTdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:33:42 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6062707
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:33:37 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id dg15so8440776vsb.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680291217; x=1682883217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nkeRp6lZuw2oE9ccSgxZK71jO5cGE2tSZwW3ZkFdEqk=;
        b=UePXZAt7YkflL11Uqp5AtS8yhrp5ZeNpc3XmqqBwTqQdgUNETufFM+ANkmP/9IhHDM
         1LeTN+UxHfOzTvQHF17AukjLmW5KxtLWQh52bq3bV32UyZrgJWctRSragRy6Q42eWsKX
         FsTmvlJQWyQFi0rOqkWJub8O+aASYb+NICUkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680291217; x=1682883217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkeRp6lZuw2oE9ccSgxZK71jO5cGE2tSZwW3ZkFdEqk=;
        b=BthvbdQPMHh0c6BcYFBU+E6+Bq+GVenxYsUQS1cHYXffnRXY2BWkk2R5Wr9KHdkVNU
         8swPGwqgHacXidpnaVo/0ILsPCQO8CrdbQFT6/PdL2ppiF8nluQk+TCyOE/HDtl6CORo
         Jwujp2w/2Ur1v4nC1hqfcoEj++wI1WZV9H0EDxHad2MnXD9X7NV1g0ouppCpFszX/caI
         tQIHpzMVaCPaB+ZUIYIy8BkSfExjeZ3pjAlFhFqWQ8YgSv77pGkD6ptpWvDKAuSC9jXk
         A0jdNy0PgDG37Ibz1nnr0oV6i8Z3V148IzeGI8a/+7kvNaS065VLAlYmMdVDNxlKYG3U
         PRJw==
X-Gm-Message-State: AAQBX9fGZas07Vjws4mDaxnxQClOhZdiSNTDcIiCQNrbDy6uBpxaMy7O
        JlCH4bfpYWCH3RBWd8qhwnZfsWVIGx5wGSTU5HqLyQ==
X-Google-Smtp-Source: AKy350atAdvrISXz+aGQuDCKa5DkiXJnHkepcGN5pRxG5f+5tKndyJwM+AsF+TRWV2Hg1l/iaRgF6yfk/JWCidSNtYo=
X-Received: by 2002:a67:d88e:0:b0:426:3a3d:180b with SMTP id
 f14-20020a67d88e000000b004263a3d180bmr14796255vsj.5.1680291216852; Fri, 31
 Mar 2023 12:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230329220753.7741-1-mario.limonciello@amd.com> <20230329220753.7741-7-mario.limonciello@amd.com>
In-Reply-To: <20230329220753.7741-7-mario.limonciello@amd.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Fri, 31 Mar 2023 13:33:26 -0600
Message-ID: <CANg-bXDCyhNohx0Rf0EndpY8ofaDs3NV0On_YT6wQCA90yO_gg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] i2c: designware: Add doorbell support for Mendocino
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Felix Held <Felix.Held@amd.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mark Hasemeyer <markhas@chromium.org>
