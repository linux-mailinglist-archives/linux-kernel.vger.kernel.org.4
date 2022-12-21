Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B2C652BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiLUDza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLUDz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:55:27 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B521CFDE;
        Tue, 20 Dec 2022 19:55:25 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u7so6125490plq.11;
        Tue, 20 Dec 2022 19:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFqFGsRyelRV58UNu8fUWuvZM10Zq7Vola1fXyGhQeA=;
        b=ng9yWkuwPkAWeYcD7l17MrG6JNu9W5xx/JGKHtPkAJyzqq1co30tVJKZkT8lAH45tY
         m01UEwA5lqWiInZXhdLPLvtTgoLQbWl52XaBfAowc+hA5ayYhSK3/xYU0mAb+MfImjvH
         bo2o45D0KG4I9HGzXWGBySJRgcyKZQeZ5ac8GHiu0bzN+Y8gmfWciM7TPv7EYrKiPpih
         ibVex1jyCcFTUGUYlmlqJYoxA3mwyPXtsQy5Jk7eeE5aCawPY/oU3f07tpRQDu8nRYga
         hLdqwXyH7elNntjIZXaYo1Pethgg2R0AFI1wpsFPzf2A5Utv2ZZABqUfGVnOXkdmB8h+
         UM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFqFGsRyelRV58UNu8fUWuvZM10Zq7Vola1fXyGhQeA=;
        b=EV2WneSnW1WghkuD4WOWgPcWbYCUF3+zQAQN9/qbKOlcT686HJR7RVnmqlwFjK0Pl0
         aARjzYQdSpHTYTaka/PXpawqfCf26mi4GO/PQGY9GGo2fIpZwodPzcEh/faYbyFBjkzV
         fDliAnuwQViLkF802EyGLcdqNBOAukb2DzSZb1uLu4kIkgDxzFbF7NsgSJkjuBaAfO33
         DuXq1Lyq7lxmKel6JE1elL7q2dKMKZf4y+X0f+UYJoVsQv276fXzQquNvUv/4VGAGF4d
         n+wgOMEzu6lD5unzzEJQp5UFogGwCugT6yMWX6cYYkeT3D0iLifMLIIfUv2TMSG1HobD
         9jWQ==
X-Gm-Message-State: AFqh2koi8ugy+0Y3E26+UicBwmsYF2374sQoZVpy6N/VuvuamjQZ0Qc2
        XRxGZO8vVhZTJ+0ezgaepOc=
X-Google-Smtp-Source: AMrXdXsckNMQT46A9gL453O+zngVYfXJ8GE6Bd1rKGuXjY4mvzMGDVaBvkEY70f8eu0vM9V4teYhsA==
X-Received: by 2002:a17:902:f14b:b0:189:b203:9e2f with SMTP id d11-20020a170902f14b00b00189b2039e2fmr359148plb.56.1671594925268;
        Tue, 20 Dec 2022 19:55:25 -0800 (PST)
Received: from debian.me (subs28-116-206-12-57.three.co.id. [116.206.12.57])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903125200b00189651e5c26sm4383363plh.236.2022.12.20.19.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 19:55:24 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 8EC76100183; Wed, 21 Dec 2022 10:55:21 +0700 (WIB)
Date:   Wed, 21 Dec 2022 10:55:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        acme@kernel.org, james.clark@arm.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 6/6] Documentation: coresight: docs for config load
 via configfs
Message-ID: <Y6KDqe26J8RyoJIV@debian.me>
References: <20221219234638.3661-1-mike.leach@linaro.org>
 <20221219234638.3661-7-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FyZ000GxMOwUmINe"
Content-Disposition: inline
In-Reply-To: <20221219234638.3661-7-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FyZ000GxMOwUmINe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2022 at 11:46:38PM +0000, Mike Leach wrote:
> diff --git a/Documentation/trace/coresight/coresight-config.rst b/Documen=
tation/trace/coresight/coresight-config.rst
> index 6d5ffa6f7347..109053eb1b93 100644
> --- a/Documentation/trace/coresight/coresight-config.rst
> +++ b/Documentation/trace/coresight/coresight-config.rst
> @@ -141,11 +141,11 @@ Mount configfs as normal and the 'cs-syscfg' subsys=
tem will appear::
>      $ ls /config
>      cs-syscfg  stp-policy
> =20
> -This has two sub-directories::
> +This has two sub-directories, with the load and unload attribute files::
> =20
>      $ cd cs-syscfg/
>      $ ls
> -    configurations  features
> +    configurations features load  unload
> =20
>  The system has the configuration 'autofdo' built in. It may be examined =
as
>  follows::
> @@ -278,9 +278,16 @@ Creating and Loading Custom Configurations
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  Custom configurations and / or features can be dynamically loaded into t=
he
> -system by using a loadable module.
> +system by using a loadable module, or by loading a binary configuration
> +file in configfs.
> =20
> -An example of a custom configuration is found in ./samples/coresight.
> +Loaded configurations can use previously loaded features. The system will
> +ensure that it is not possible to unload a feature that is currently in
> +use, by enforcing the unload order as the strict reverse of the load ord=
er.
> +
> +
> +Using a Loadable Module
> +-----------------------
> =20
>  This creates a new configuration that uses the existing built in
>  strobing feature, but provides a different set of presets.
> @@ -289,6 +296,187 @@ When the module is loaded, then the configuration a=
ppears in the configfs
>  file system and is selectable in the same way as the built in configurat=
ion
>  described above.
> =20
> -Configurations can use previously loaded features. The system will ensure
> -that it is not possible to unload a feature that is currently in use, by
> -enforcing the unload order as the strict reverse of the load order.
> +The file 'coresight-cfg-sample.c' contains the configuration and module
> +initialisation code needed to create the loadable module.
> +
> +This will be built alongside the kernel modules if select in KConfig.

What config options (CONFIG_) are required for above to work?

> +
> +An example of a custom configuration module is found in './samples/cores=
ight'.
> +
> +Using a Binary Configuration File
> +---------------------------------
> +
> +The './tools/coresight' directory contains example programs to generate =
and
> +read and print binary configuration files.
> +
> +Building the tools creates the 'coresight-cfg-file-gen' program that will
> +generate a configuration binary 'example1.cscfg' that can be loaded into=
 the
> +system using configfs. The configuration declared in the source file
> +'coresight-cfg-example1.c' is named 'autofdo3' - the name that will be u=
sed
> +once loaded.
> +
> +The source files 'coresight-cfg-bufw.h' and 'coresight-cfg-bufw.c' provi=
de a
> +standard function to convert a configuration declared in 'C' into the co=
rrect
> +binary buffer format. These files can be re-used to create new custom
> +configurations. Alternatively, addition examples can be added to the

s/addition/additional/

> +'coresight-cfg-file-gen' program::
> +
> +    $ ./coresight-cfg-file-gen
> +    Coresight Configuration file Generator
> +
> +    Generating example1 example
> +    Generating example2 example
> +
> +The program 'coresight-cfg-file-read' can read back and print a configur=
ation
> +binary. This is built using the file reader from the driver code
> +(coresight-config-file.c), which is copied over into './tools/coresight'=
 at
> +build time.::
> +
> +    ./coresight-cfg-file-read example1.cscfg
> +    CoreSight Configuration file reader
> +    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +    Configuration 1
> +    Name:- autofdo3
> +    Description:-
> +    Setup ETMs with strobing for autofdo
> +    Supplied presets allow experimentation with mark-space ratio for var=
ious loads
> +
> +    Uses 1 features:-
> +    Feature-1: strobing
> +
> +    Provides 4 sets of preset values, 2 presets per set
> +    set[0]: 0x7d0, 0x64,
> +    set[1]: 0x7d0, 0x3e8,
> +    set[2]: 0x7d0, 0x1388,
> +    set[3]: 0x7d0, 0x2710,
> +
> +    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +    File contains no features
> +
> +There are additional attributes in the cs-syscfg directory - load and
> +unload that can be used to load and unload configuration binary files. To
> +load, 'cat' the binary config into the load attribute::
> +
> +    $ ls /config/cs-syscfg
> +    configurations features  load  unload
> +    $ cat example1.cscfg > /config/cs-syscfg/load
> +    $ ls /config/cs-syscfg/configurations/
> +    autofdo  autofdo3
> +
> +To unload, use the same file in the unload attribute::
> +
> +    $ cat example1.cscfg > /config/cs-syscfg/unload
> +    ls /config/cs-syscfg/configurations/
> +    autofdo
> +
> +
> +
> +Binary Configuration File Format
> +--------------------------------
> +
> +The file format is defined in the source file **coresight-config-file.h**

Use single-quote for identifier names for consistency here.

> +
> +The source reader and generator examples produce a binary of this format.
> +
> +This arrangement is reproduced below:-
> +
> +Overall File structure
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   [cscfg_file_header]   // Mandatory
> +   [CONFIG_ELEM]*        // Optional - multiple, defined by cscfg_file_h=
eader.nr_configs
> +   [FEATURE_ELEM]*       // Optional - multiple, defined by cscfg_file_h=
eader.nr_features
> +
> +File is invalid if both [CONFIG_ELEM] and [FEATURE_ELEM] are omitted.
> +
> +A file that contains only [FEATURE_ELEM] may be loaded, and the features=
 used
> +by subsequently loaded files with [CONFIG_ELEM] elements.
> +
> +Element Name Strings
> +~~~~~~~~~~~~~~~~~~~~
> +
> +Configuration name strings are required to consist of alphanumeric chara=
cters and '_' only. Other special characters are not permitted.
> +
> +::
> +   my_config_2          // is a valid name.
> +   this-bad-config#5    // this will not work

Instead of using code-block for name examples, what about "... For
example, foo_bar is a valid name where as foo-bar# is not."?

> +
> +This is in order to comply with the requirements of the perf command lin=
e.
> +
> +It is recommended that Feature and Parameter names use the same conventi=
on to allow for future enhancements to the command line syntax.
> +
> +CONFIG_ELEM element
> +~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   [cscfg_file_elem_header]                // header length value to end=
 of feature strings.
> +   [cscfg_file_elem_str]                   // name of the configuration.
> +                                           // (see element string name r=
equirements)
> +   [cscfg_file_elem_str]                   // description of configurati=
on.
> +   [u16 value](nr_presets)                 // number of defined sets pre=
sets values.
> +   [u32 value](nr_total_params)            // total parameters defined b=
y all used features.
> +   [u16 value](nr_feat_refs)               // number of features referen=
ced by the configuration
> +   [u64 values] * (nr_presets * nr_total_params)     // the preset value=
s.
> +   [cscfg_file_elem_str] * (nr_feat_refs)  // names of features used in =
the configurations.
> +
> +FEATURE_ELEM element
> +~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   [cscfg_file_elem_header]                // header length is total byt=
es to end of param structures.
> +   [cscfg_file_elem_str]                   // feature name.
> +   [cscfg_file_elem_str]                   // feature description.
> +   [u32 value](match_flags)                // flags to associate the fea=
ture with a device.
> +   [u16 value](nr_regs)                    // number of registers.
> +   [u16 value](nr_params)                  // number of parameters.
> +   [cscfg_regval_desc struct] * (nr_regs)  // register definitions
> +   [PARAM_ELEM] * (nr_params)              // parameters definitions
> +
> +PARAM_ELEM element
> +~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   [cscfg_file_elem_str]         // parameter name.
> +   [u64 value](param_value)      // initial value.
> +
> +Additional definitions.
> +~~~~~~~~~~~~~~~~~~~~~~~

Trim trailing period for section names

> +
> +The following structures are defined in **coresight-config-file.h**
> +
> + * **struct cscfg_file_header** : This structure contains an initial mag=
ic number, the total
> +   length of the file, and the number of configurations and features in =
the file.
> + * **struct cscfg_file_elem_header**: This defines the total length and =
type of a CONFIG_ELEM
> +   or a FEATURE_ELEM.
> + * **struct cscfg_file_elem_str**: This defines a string and its length.

Again, for consistency, wrap identifier names in single-quotes.

> +
> +The magic number in cscfg_file_header is defined as two bitfields::
> +
> +   [31:8] Fixed magic number to identify file type.
> +   [7:0]  Current file format version.
> +
> +The following defines determine the maximum overall file size and maximu=
m individual
> +string size::
> +
> +   CSCFG_FILE_MAXSIZE       // maximum overall file size.
> +   CSCFG_FILE_STR_MAXSIZE   // maximum individual string size.

For parameter lists in elements, use bullet lists instead.

> +
> +Load Dependencies.
> +~~~~~~~~~~~~~~~~~~

Trim trailing period for section names.
> +
> +Files may be unloaded only in the strict reverse order of loading. This =
is enforced by the
> +configuration system.
> +
> +This is to ensure that any load dependencies are maintained.
> +
> +A configuration file that contains a CONFIG_ELEM that references named f=
eatures "feat_A" and "feat_B" will load only if either:-
> +a) "feat_A" and/or "feat_B" has been loaded previously, or are present a=
s built-in / module loaded features.
> +b) "feat_A" and/or "feat_B" are declared as FEAT_ELEM in the same file a=
s the CONFIG_ELEM.

Separate the preceding paragraph and the list with a blank line in order
for the list to be rendered as list.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--FyZ000GxMOwUmINe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY6KDowAKCRD2uYlJVVFO
o9PrAQCKIWF+ulp0vCakhJ7l3aHILy4sSDT4w5GSUA89FFmwfwD+Kwj4HqGhZJ1j
gB1KE9nt45jeT6c85kqXXyjifLzfMww=
=8h8k
-----END PGP SIGNATURE-----

--FyZ000GxMOwUmINe--
