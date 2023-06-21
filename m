Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD48738A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjFUQF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjFUQFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:05:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266C8F1;
        Wed, 21 Jun 2023 09:05:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9889952ed18so564524766b.3;
        Wed, 21 Jun 2023 09:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687363552; x=1689955552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk1BnNVlzELodZUgAlHBrILAdmGoba/tHKb54nkrU0Y=;
        b=ZT7wQmwkKHcyXm5r53h2mKMlJalLvOwBS8thd4bw7+CD+40xH5yiW6yJ50BnU0RDK5
         CnURfQ1rjLJwyiy4/iwk0jU4w5w2Jwrj0UiieuKiEJDFPGtELpVkORP2AA7sDtAxKf/H
         dGi3nKBkDPzL+Uk7MHi+o1aLiFY58+ArJF7P+N88z/OJ/UlBXve2yhvAAf0L3iwY8Nir
         zXk8pAE8C9+iP744rpPRX4V+Lqbz8TBtKJ7xluDkUUIKCRKZygmzIRw9MZbs5zsukFo7
         foG9ohwOwUYIQA/CtiEoI73tItd+UiIunoTAr/UPilPitY617/ThXx3ahvwIeyR8/m3H
         /Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687363552; x=1689955552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kk1BnNVlzELodZUgAlHBrILAdmGoba/tHKb54nkrU0Y=;
        b=OGa8Q+44E/5WtZ2+Nm6XY9D/7KFFHpvKRPjTCP9QvsKWrQHn0XmAMjhj+nkt9bDbNB
         tlztUGKD0kxWcpoIPl6/bdqSxahdUskb5p0Bn/0Vjc3Ug5+fhB4KfAJUWoIyQ53rmUTC
         Z7XHimgSDHP3sha05agsVvUlW/Tndj9efeN6yEBhrmD/bu4tM6fWqSl2oxId5WTnKKD5
         sOfWxiMLpDNxW1arByFU7CwbSeByjQTvTF/wZcG0F8vDbdf0eW5KrLSPlYGurbxVpvCT
         esjuaSs5p3o+lKWIZyWAWRg5adN3t18XxfvWtCe47WpXM3wtzVTdvluihZFUQ153TNbr
         0FNQ==
X-Gm-Message-State: AC+VfDwGKmHGvZSKQTPJoXQulMm2b02Ywbb87ET86j93fc9cv/NVir7t
        ENxRI5qdVukvPmevVu6JbXk=
X-Google-Smtp-Source: ACHHUZ7+dillI7PPdXk5/JfbaJxtmwtPKD3w2HLMqM7BP+d9XjsgD8q0lpGMeA79Xbrq0UxB6iWunA==
X-Received: by 2002:a17:907:720c:b0:987:5ade:12a5 with SMTP id dr12-20020a170907720c00b009875ade12a5mr11581864ejc.26.1687363552231;
        Wed, 21 Jun 2023 09:05:52 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090614cc00b0098951bb4dc3sm2345530ejc.184.2023.06.21.09.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 09:05:51 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     bbara93@gmail.com, benjamin.bara@skidata.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mka@chromium.org, robh+dt@kernel.org
Subject: Re: [PATCH 1/4] usb: misc: onboard-hub: resort by VID and PID
Date:   Wed, 21 Jun 2023 18:05:43 +0200
Message-Id: <20230621160543.2231508-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023062136-subgroup-aground-01e2@gregkh>
References: <2023062136-subgroup-aground-01e2@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 21 Jun 2023 at 17:59, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This does nothing except make backports harder over time :(
>
> And this also does nothing to help really, so it's not needed, sorry.

thanks for the feedback, I already dropped it and sent out v3[1].

Sorry for the inconvenience.

br,
Benjamin

[1] https://lore.kernel.org/lkml/20230620-hx3-v3-0-2acbc03ca949@skidata.com/
