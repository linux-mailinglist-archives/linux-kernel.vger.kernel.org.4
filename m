Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B136017F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiJQTo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiJQTor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:44:47 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EFA1F9ED
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:44:43 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id y72so13321498oia.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CN+vhPEGNqZzmOiuUIghOz2shKeTb0/8p2TGRq9W0p4=;
        b=KRM/FyVcmtY7kQ6FiXhyUsIZVeIZgZhUXes0/Vg4u62zXEGyYeKT9A/l5xeuc0lT8A
         9tITbVezmmMyoNyBKQO8N4WbIsBRX28zlRmQlKwALhSlM0iTH67x6Dabl5ZxzcRhjmxc
         6hlEm0bk7wIxHwKnArDf58B3PpzMoE3fQXfd7a4nXeffTZjNe3v4NyIVTbHM8HKbld4A
         C+/a5HjFYZhM1YncZO0PR8Vgi66lRwchsAOd4AyL1idEowish+wWzHAk5n99j3nOS14X
         LOkFOULQlBbqU58bs7VqG0qznxLJef/Q3ShKKYyj9+tkvf4xIN86w/59O/0J6DHfKsN9
         o1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CN+vhPEGNqZzmOiuUIghOz2shKeTb0/8p2TGRq9W0p4=;
        b=s7rGudwoHDEkeod06Oy7sDfR6MYV1oQ1gBJsmhHSHpb89bX+WvdXbQs7a+lnLIto3O
         x9/oKpColb/yDi1zrXQ/jTrvaQMwq3I2OiQTsQ6N5rw0UiIg4JYfTq9ZtHiGFuOONdDr
         gZ0x6oKR56kV/SvoVbUGSf2UkiOXtKx7VAh3gaqFYx7+FzPxXZ5GHxCCscdA4g/xtqnT
         IsCbFZFiIVZj6S4j7wwGBoGaHEiZAdDz2mM1x0l6zF+NkROktQbHYXbb0qP9uYcDz0OI
         u73EAVnCzOHiSIAhK8vUe3AJSPDbQHRc19XIBGvuE+R/cMG5mvjmoiv/bd0F2d9Kosys
         yzbg==
X-Gm-Message-State: ACrzQf1p6hnLHAE51Rd2TJZ99CEo+KWq0gi/gtmfj9gCTyp5086qNch7
        QiTAYoF9doSEbLRJx9dYr9TcNKUTyTRxYmOG
X-Google-Smtp-Source: AMsMyM6CTzJujzzV6ymHF4yQxJJZ9ZgRGVVlL9gc5/FudeV+ftuaEfNiWAu0nDJwIAN9pXcVbzXUWw==
X-Received: by 2002:a05:6808:2226:b0:354:ab07:4f12 with SMTP id bd38-20020a056808222600b00354ab074f12mr5701540oib.234.1666035882924;
        Mon, 17 Oct 2022 12:44:42 -0700 (PDT)
Received: from localhost.localdomain (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id bp9-20020a056808238900b0035474ff66b3sm4741256oib.35.2022.10.17.12.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:44:42 -0700 (PDT)
From:   Steev Klimaszewski <steev@kali.org>
To:     fntoth@gmail.com
Cc:     Thinh.Nguyen@synopsys.com, andrew.smirnov@gmail.com,
        andriy.shevchenko@linux.intel.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Revert "usb: dwc3: Don't switch OTG -> peripheral if extcon is present"
Date:   Mon, 17 Oct 2022 14:44:39 -0500
Message-Id: <20221017194439.3829-1-steev@kali.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <887510d7-b732-2b0e-e177-615de59cfaf8@gmail.com>
References: <887510d7-b732-2b0e-e177-615de59cfaf8@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This revert breaks USB on the Lenovo Yoga C630.

sudo cat /sys/kernel/debug/devices_deferred
a800000.usb     platform: supplier 88e3000.phy not ready
88e2000.phy
88e3000.phy
a600000.usb     platform: supplier 88e2000.phy not ready

Nothing seems to indicate there is any breakage in the dmesg output though, just
that deferred probe is pending.

qcom-qmp-usb-phy 88e9000.phy: Registered Qcom-QMP phy
qcom-qmp-usb-phy 88eb000.phy: Registered Qcom-QMP phy
platform a800000.usb: deferred probe pending
platform a600000.usb: deferred probe pending

-- steev
