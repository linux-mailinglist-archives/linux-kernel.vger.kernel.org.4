Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE89B6DF976
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDLPNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDLPNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:13:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C609A19A0;
        Wed, 12 Apr 2023 08:13:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id kh6so10146786plb.0;
        Wed, 12 Apr 2023 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681312423; x=1683904423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sztLFyS4uvBBtM8IY9tVKFzpMMoTq4vlM6dKfrxG2Y8=;
        b=nEPsbrR6mISEAN/2Bqwb5kiIGN2vKr9TeFPUv1Sg5Tj7/ZnnSQl4MIj474xgl0XxTu
         kSzuJTcc9cKsUJda+snt4SW+5XP3NZCEhd/Oj6aIGJheJQCtJJ8A0ILzZwlRFd4wZX1d
         W3k78e8u2+1w6zad4UYbSxlB9gJaGuM30Vc8/Tx//gwupTAdeXaR2aW7aQsIwS5uSFQF
         MbHXXjYJAaDC2xnFyBPSSS2oWMTqhbyCWoAfKpAkfVQlHDadcU5n72HszeJWNLxlKsJC
         Q7KX8exrL3cXw04+dhcLeFzgqn8wv5BSorzl/ItQk4jcBmXvTYuQMIBPPpdk2X9weX7N
         idrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681312423; x=1683904423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sztLFyS4uvBBtM8IY9tVKFzpMMoTq4vlM6dKfrxG2Y8=;
        b=MgmiD54+zggJnDpPmqwXYCS7Zcj5p091tsRZPqIA4ZTiVBYQ873Iqbq0ZjFzdMXj9Q
         RS5lri9iSrDphcLDHqvRDtyhdemXW7zVeiYqe84ey8bgWQu8i+g3R4riP6fu0E+I2+1K
         t9i1FYucYnTKHPO0ju4qQ/+vrEn5F7FTjlqFzpeeImKFDP/rYbcRMU4G8rmZGhv32K22
         8tv35NqPsNHB5qjaabU3DtGmAvKLONgJ0xZHKNeR+98NGtsuDMoD5uOR1D+SEHQXGRm1
         RDZNZiBS7T7kzxjNNh/x23lvY9Ksht7XhMHgejS232oDwQW9Z7e08R/GhmExCW9pN2nn
         PDGA==
X-Gm-Message-State: AAQBX9eOAB8/a+LWt8RBXktVV54S+bPH49tLBn151NFR1GA/T9K4+rYN
        BlL0AATjXc6c82k39g546Ak=
X-Google-Smtp-Source: AKy350bD3FxvTt2LckWFVO+Cd0ejFuK8YxUtabTfRk4Ikq2MR7d9TxAt6QxE2u3Tspmsi81ZQAcbWA==
X-Received: by 2002:a17:90a:6042:b0:23a:177b:5bfa with SMTP id h2-20020a17090a604200b0023a177b5bfamr9740788pjm.22.1681312423254;
        Wed, 12 Apr 2023 08:13:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090abe0500b002407c8f89aasm1602811pjs.24.2023.04.12.08.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:13:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Apr 2023 08:13:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] hwmon: (pmbus/core): Add regulator event support
Message-ID: <d3e35ca5-9924-4831-a18c-ab128c936c95@roeck-us.net>
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
 <20230328150335.90238-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328150335.90238-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 05:03:34PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add regulator events corresponding to regulator error in regulator flag
> map.
> Also capture the same in pmbus_regulator_get_flags.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied to hwmon-next.

Thanks,
Guenter
